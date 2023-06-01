# dotfiles binaries
if [[ -d "$ZDOTDIR/bin" ]]; then
  export PATH="$ZDOTDIR/bin:$PATH"
fi

# krew plugin
if [[ -x "$HOME/.krew/bin/kubectl-krew" ]]; then
  export PATH="$HOME/.krew/bin:$PATH"
fi

# gnu sed
if [[ -x "/usr/local/opt/gnu-sed/libexec/gnubin/sed" ]]; then
  export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
fi

# gnu make
if [[ -x "/usr/local/opt/make/libexec/gnubin/make" ]]; then
  export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"
fi

# brew curl
if [[ -x "/usr/local/opt/curl/bin/curl" ]] ; then
  export PATH="/usr/local/opt/curl/bin:$PATH"
fi
