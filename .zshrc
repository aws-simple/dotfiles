export ZSH="$ZDOTDIR/ohmyzsh"

ZSH_CUSTOM=$ZDOTDIR
ZSH_THEME="simple"

HIST_STAMPS="yyyy-mm-dd"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  z
)

source $ZSH/oh-my-zsh.sh

# User configuration
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
