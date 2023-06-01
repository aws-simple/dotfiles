alias ll='ls -la'

alias k='kubectl'
alias d='docker'

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
