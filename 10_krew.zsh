if (( ! $+commands[kubectl] )); then
  return
fi

if [[ ! -x "$HOME/.krew/bin/kubectl-krew" ]]; then
  echo "'krew' and its plugins are to be installed"
  (
  set -x
  cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
  ) > "$HOME/.krew_install.log" 2>&1

  $HOME/.krew/bin/kubectl-krew update      >> "$HOME/.krew_install.log" 2>&1
  $HOME/.krew/bin/kubectl-krew install ctx >> "$HOME/.krew_install.log" 2>&1
  $HOME/.krew/bin/kubectl-krew install ns  >> "$HOME/.krew_install.log" 2>&1

  echo "'krew' is installed, see log is in '$HOME/.krew_install.log'"
fi
