export ZSH="$ZDOTDIR/ohmyzsh"

export HOMEBREW_CACHE=/Volumes/Data/$HOME/Library/Caches/Homebrew

export DEFAULT_USER="$(whoami)"

ZSH_CUSTOM=$ZDOTDIR/custom
ZSH_THEME="simple"
setopt AUTO_PUSHD

HIST_STAMPS="yyyy-mm-dd"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  av
  git
  nvm
  terraform
  z
)

source $ZSH/oh-my-zsh.sh

# User configuration
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# ZSH_AUTOSUGGEST_STRATEGY=(completion history)
# bindkey '^I' autosuggest-accept

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# eval "$(mise activate zsh)"

test -e $HOME/.zsh/.iterm2_shell_integration.zsh && source $HOME/.zsh/.iterm2_shell_integration.zsh || true

# >>> agterm agent-status >>>
source $HOME/.config/agterm/agent-status/shell/integration.sh
# <<< agterm agent-status <<<
