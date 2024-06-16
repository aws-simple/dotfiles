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
alias pass16="dd if=/dev/urandom bs=1 count=64 2>/dev/null | base64 | rev | cut -b 5- | rev | tr '[:upper:]' '[:lower:]' | tr -d '[:special:]' | tr -d '[:punct:]' | head -c16 ; echo"

alias reloadshell="source $ZDOTDIR/.zshrc"
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"

alias kxl='f() { kubectl config get-contexts --no-headers -o name ; } ; f'
alias knl='f() { kubectl get ns -o jsonpath='\''{range .items[*].metadata}{.name}{"\n"}{end}'\'' ; } ; f'

alias myip='curl https://checkip.amazonaws.com'
