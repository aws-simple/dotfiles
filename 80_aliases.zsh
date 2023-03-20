### K8s and Containers
alias k='kubectl'
alias d='docker'

# Krew plugin aliases
if [[ -x "$HOME/.krew/bin/kubectl-krew" ]]; then
  alias kn='kubectl ns'
  alias kx='kubectl ctx'
fi

### Misc
alias envg='f_envg() { if [[ -n $1 ]] ; then env | grep -i $1 ; else env | sort ; fi ; } ; f_envg'
alias copyssh="pbcopy < $HOME/.ssh/id_ed25519.pub"
alias reloadshell="source $HOME/.zsh/.zshrc"
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias ll="/usr/local/opt/coreutils/libexec/gnubin/ls -AhlFo --color --group-directories-first"
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias c="clear"

alias cz='cd $(z | tail -1 | sed -e "s/^[^ ]* *//")'
alias pass32="dd if=/dev/urandom bs=1 count=64 2>/dev/null | base64 | rev | cut -b 5- | rev | tr '[:upper:]' '[:lower:]' | tr -d '[:special:]' | tr -d '[:punct:]' | head -c32 ; echo"
alias pass40="dd if=/dev/urandom bs=1 count=64 2>/dev/null | base64 | rev | cut -b 5- | rev | tr '[:upper:]' '[:lower:]' | tr -d '[:special:]' | tr -d '[:punct:]' | head -c40 ; echo"

# Directories
alias dotfiles="cd $DOTFILES"
alias library="cd $HOME/Library"

# Git
alias gst="git status"
alias gbr="git branch"
alias gco="git checkout"
alias glo="git log --oneline --decorate --color"
alias gdf="git diff"
alias gdi="git diff"
alias amend="git add . && git commit --amend --no-edit"
alias commit="git add . && git commit -m"
alias force="git push --force"
alias nuke="git clean -df && git reset --hard"
alias pop="git stash pop"
alias pull="git pull"
alias push="git push"
alias resolve="git add . && git commit --no-edit"
alias stash="git stash -u"
alias unstage="git restore --staged ."

alias wip="commit wip"
alias compile="commit 'compile'"
alias version="commit 'version'"
