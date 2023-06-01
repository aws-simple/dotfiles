if (( ! $+commands[goenv] )); then
  return
fi

if [[ ! -d $HOME/.goenv ]]; then
  mkdir $HOME/.goenv
  cat <<- _EOF
	Directory "$HOME/.goenv" has been created.
	Use the following commands to proceed with 'go' installation:
	- goenv install -l        # List all available versions
	- goenv install <version> # Install the specific <version>
	- goenv global <version>  # Sets the global Go version to the specific <version>
	_EOF
fi

if (( ! $+GOENV_ROOT )); then
  export GOENV_ROOT="$HOME/.goenv"
  export PATH="$GOENV_ROOT/bin:$PATH"
  eval "$(goenv init -)"
fi

if (( $+GOROOT )); then
  export PATH="$GOROOT/bin:$PATH"
fi

if (( $+GOPATH )); then
  export PATH="$PATH:$GOPATH/bin"
fi
