# Load dotfiles binaries
export PATH="$DOTFILES/bin:$PATH"

# Krew plugin
if [[ -x "$HOME/.krew/bin/kubectl-krew" ]]; then
  export PATH="$HOME/.krew/bin:$PATH"
fi

# Make sure coreutils are loaded before system commands
# I've disabled this for now because I only use "ls" which is
# referenced in my aliases.zsh file directly.
#export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
