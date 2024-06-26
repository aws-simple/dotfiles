# kselpod: 'kubectl get pod -A' and filtered by nodes with node labels selected with 1-st argument to alias, like 'kselpod purpose=workers'
function kselpod {
  if [[ -n $1 ]] ; then
    kubectl get pod -A -o json | \
    jq -r --argjson list $(kubectl get node -l ${1} -o json | jq '[.items[].metadata.name]' -c) \
    '.items[] | select(.spec.nodeName == ($list[])) | [ .metadata.name, .metadata.namespace, .spec.nodeName] | @csv'
  else
    echo 'arg in a form of "-l" node filter is needed, like "kselpod purpose=workers"'
  fi
}

# ktopcpu: 'kubectl top pod --sort-by=cpu' and filtered by nodes in node group which are selected with 1-st argument to alias, like 'ktopcpu purpose=workers'
function ktopcpu {
  if [[ -n $1 ]] ; then
    kubectl top pods --no-headers -A --sort-by=cpu | \
    grep -f <(kubectl get pod -A --no-headers -o wide | \
    grep -f <(kubectl get nodes -l ${1} -oname | sed -e 's|^node/||') | awk '{print $2}')
  else
    kubectl top pods --no-headers -A --sort-by=cpu
  fi
}

# ktopmem: 'kubectl top pod --sort-by=memory' and filtered by nodes in node group which are selected with 1-st argument to alias, like 'ktopmem purpose=workers'
function ktopmem {
  if [[ -n $1 ]] ; then
    kubectl top pods --no-headers -A --sort-by=memory | \
    grep -f <(kubectl get pod -A --no-headers -o wide | \
    grep -f <(kubectl get nodes -l ${1} -oname | sed -e 's|^node/||') | awk '{print $2}')
  else
    kubectl top pods --no-headers -A --sort-by=memory
  fi
}

# kubeall: all k8s objects namespaced in current namespace (or in all namespaces if invoked with '-A' key)
function kubeall {
  local message="No resources found"
  local all="false"
  if [[ -n $1 ]] && [[ $1 == "-A" ]] ; then
    all="true"
  else
    local ns=$(kubectl config view --minify | grep namespace: | cut -d" " -f6)
    message="No resources found in $ns namespace."
    printf "NAMESPACE: $ns\n"
  fi

  local tmpfile=$(mktemp)
  kubectl api-resources --namespaced=true --no-headers | awk "{print \$1}" | sort | uniq | \
    while read i ; do
      kubectl get $(test "$all" != "true" || echo "-A") $i > $tmpfile 2>&1
      if test $? -eq 0 -a "$(cat $tmpfile)" != "$message" ; then
        printf "====== \e[1;34m%30s\e[m ======\n" $i
        cat $tmpfile
      fi
    done
  rm -fr $tmpfile
}

# kubeuns: k8s objects non-namespaced = UNname-Spased
function kubeuns {
  local tmpfile=$(mktemp)
  kubectl api-resources --namespaced=false --no-headers | awk "{print \$1}" | sort | uniq | \
    while read i ; do
     kubectl get $i > $tmpfile 2>&1
     if test $? -eq 0 -a "$(cat $tmpfile)" != "No resources found" ; then
       printf "====== \e[1;34m%30s\e[m ======\n" $i
       cat $tmpfile
     fi
   done
  rm -fr $tmpfile
}

# kuberes: k8s nodes with their resources (cpu, memory) allocatable of capacity
function kuberes {
  kubectl get no -o json | \
    jq -r '.items[].status |
      [ "cpu: ", .allocatable.cpu, "of", .capacity.cpu, "mem: ", .allocatable.memory, "of", .capacity.memory] as $res |
      [ $res[], [.addresses[] | select(.type=="InternalIP" or .type=="ExternalIP" or .type=="Hostname") | .address][] ]
      | @tsv' | sed -e 's/\tof\t/\//g' | sort -k5
}

# kubepods: k8s pods grouped and sorted by nodes they run on
function kubepods {
  if [[ -n $1 ]] && [[ $1 == "-A" ]] ; then
    kubectl get pods -A -o wide --no-headers | \
      grep -v "Completed" | \
      sort -k8b,8 -k1,1 -s | \
      awk 'BEGIN {stor=$8} {if(stor != $8){print ""} print $0; stor=$8}' | \
      sed -e 's/<none>//g' -e 's/[ ]\+$//' | \
      column -te
  else
    kubectl get pods    -o wide --no-headers | \
      grep -v "Completed" | \
      sort -k7b,7 -k1,1 -s | \
      awk 'BEGIN {stor=$7} {if(stor != $7){print ""} print $0; stor=$7}' | \
      sed -e 's/<none>//g' -e 's/[ ]\+$//' | \
      column -te
  fi
}

# eksnodes: EKS nodes sorted by their names and grouped by their nodegroups
function eksnodes {
  kubectl get nodes -o json | \
    jq -r '.items[] |
    .metadata.labels."eks.amazonaws.com/nodegroup" as $ng |
    .metadata.name as $name |
    [ [.status.addresses[] | select(.type=="InternalIP") | .address][],
      $ng,
      $name,
      [.status.conditions[] | select(.type=="Ready") | .reason][]
    ] | @tsv' | \
    column -t | \
    sed 's/-/#/g' | \
    sort -t'#' -k2 -k1 -s | \
    sed 's/#/-/g' | \
    awk 'BEGIN {stor=$2} {if(stor != $2){print ""} print $0; stor=$2}'
}

# eksngrp: EKS node groups with their nodes and the node's pods
function eksngrp {
  local tmpfile=$(mktemp)
  kubectl get nodes -o json | \
    jq -r '.items[] |
    .metadata.labels."eks.amazonaws.com/nodegroup" as $ng |
    [ [.status.addresses[] | select(.type=="InternalIP") | .address][],
      $ng
    ] | @tsv' | \
    column -t | \
    awk '{print "s/" $1 "\t/" $2 " " $1 " /";}' > $tmpfile.sed

  kubectl get pods -A -o json | \
    jq -r '.items[] | .status.hostIP as $ip | [ $ip, .metadata.namespace, .metadata.name ] | @tsv' | \
    sed -f $tmpfile.sed | \
    column -t | \
    sed 's/-/#/g' | \
    sort -t'#' -s | \
    sed 's/#/-/g' | \
    awk 'BEGIN {stor=$2} {if(stor != $2){print ""} print $0; stor=$2}'

  rm -fr $tmpfile.sed
}

# helmsec: content of helm secret
# kubectl get secret sh.helm.release.v1.myrel.v1 -o go-template='{{.data.release | base64decode | base64decode}}' | gzip -d | jq
# see https://gist.github.com/DzeryCZ/c4adf39d4a1a99ae6e594a183628eaee
helmsec () {
    local fetchSecretJson
    local doesSecretExist
    if [[ -z "${1}" ]]; then
        echo "Missing secret name. Terminating"
        exit 1
    else
        if [[ "${1}" == *"sh.helm.release"* ]]; then
            fetchSecretJson=$(kubectl get secret --ignore-not-found --all-namespaces --output json --field-selector "metadata.name=${1}")
            doesSecretExist=$(echo "${fetchSecretJson}" | jq --raw-output 'if (.items | length) > 0 then "true" else empty end')
            if [[ "${doesSecretExist}" == "true" ]]; then
                echo "${fetchSecretJson}" | jq --raw-output '.items[0].data.release' | base64 -d | base64 -d | gzip -d
            else
                echo "There is no such helm secret on this cluster"
            fi
        else
            echo "This is not a helm secret :("
        fi
    fi
}
