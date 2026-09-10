# dotfiles binaries
if [[ -d "$ZDOTDIR/bin" ]]; then
  export PATH="$ZDOTDIR/bin:$PATH"
fi

# krew plugin
if [[ -x "$HOME/.krew/bin/kubectl-krew" ]]; then
  export PATH="$HOME/.krew/bin:$PATH"
fi

# gnu sed
if [[ -x "/opt/homebrew/opt/gnu-sed/libexec/gnubin/sed" ]]; then
  export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
fi

# gnu make
if [[ -x "/opt/homebrew/opt/make/libexec/gnubin/make" ]]; then
  export PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"
fi

# brew curl
if [[ -x "/opt/homebrew/opt/curl/bin/curl" ]] ; then
  export PATH="/opt/homebrew/opt/curl/bin:$PATH"
fi

# .local/bin
if [[ -d "$HOME/.local/bin" ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi
