alias ash='f_ash() { if [[ -n $1 ]] ; then test "$1" = "kill" && kill $(ps aux | grep autossh | grep -v grep | awk "{print \$2}") || autossh -f -M 0 $1 -xCNT -D 12345 -o ServerAliveInterval=10 -o ServerAliveCountMax=1 -o ExitOnForwardFailure=yes -o StrictHostKeyChecking=accept-new ; else ps aux | grep autossh | grep -v grep ; fi ; } ; f_ash'

alias ll='ls -la'
alias lr='ls -ltr'
alias la='ls -ltra'

alias d='docker'
alias g='git'
alias h='helm'
alias k='kubectl'
alias t='terraform'
alias o='openssl'

if [[ -x "$HOME/.krew/bin/kubectl-krew" ]]; then
  alias kn='kubectl ns'
  alias kx='kubectl ctx'
fi

alias eg='f_eg() { if [[ -n $1 ]] ; then env | grep -i $1 ; else env | sort ; fi ; } ; f_eg'
alias cz='cd $(z | tail -1 | sed -e "s/^[^ ]* *//")'

alias pass32="dd if=/dev/urandom bs=1 count=64 2>/dev/null | base64 | rev | cut -b 5- | rev | tr '[:upper:]' '[:lower:]' | tr -d '[:special:]' | tr -d '[:punct:]' | head -c32 ; echo"
alias pass40="dd if=/dev/urandom bs=1 count=64 2>/dev/null | base64 | rev | cut -b 5- | rev | tr '[:upper:]' '[:lower:]' | tr -d '[:special:]' | tr -d '[:punct:]' | head -c40 ; echo"

alias reloadshell="source $ZDOTDIR/.zshrc"
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"

alias kxl='f() { kubectl config get-contexts --no-headers -o name ; } ; f'
alias knl='f() { kubectl get ns -o jsonpath='\''{range .items[*].metadata}{.name}{"\n"}{end}'\'' ; } ; f'

alias pon='f() {
  if [[ ! -r /usr/local/etc/tinyproxy/tinyproxy.conf ]]; then return ; fi
  port=$(cat /usr/local/etc/tinyproxy/tinyproxy.conf | grep ^Port | cut -f2 -d" ")
  if [[ ! -n "$port" ]]; then return ; fi
  export http_proxy=http://127.0.0.1:$port
  export HTTP_PROXY=http://127.0.0.1:$port
  export https_proxy=http://127.0.0.1:$port
  export HTTPS_PROXY=http://127.0.0.1:$port
  export no_proxy="10.0.0.0/8,172.16.0.0/12,192.168.0.0/16,127.0.0.0/8"
  export NO_PROXY="10.0.0.0/8,172.16.0.0/12,192.168.0.0/16,127.0.0.0/8"
  }
f'

alias poff='unset http_proxy; unset HTTP_PROXY; unset https_proxy; unset HTTPS_PROXY; unset no_proxy; unset NO_PROXY'
alias unproxy='unset http_proxy; unset HTTP_PROXY; unset https_proxy; unset HTTPS_PROXY; unset no_proxy; unset NO_PROXY'
