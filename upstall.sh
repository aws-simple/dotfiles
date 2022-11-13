#!/usr/bin/env sh

TS=$(date "+%Y%m%d_%H%M%S")

SCRIPT_NAME="$(basename "$0")"
pushd $(dirname "$0") > /dev/null
SCRIPT_DIR=$(pwd)
popd > /dev/null

echo "== log: init OMZ"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

cat > $HOME/.zshenv << '_EOF'
ZDOTDIR=$HOME/.zsh
_EOF

test ! -e $HOME/.zsh || mv $HOME/.zsh $HOME/.home.zsh.bckp.${TS}
ln -s $SCRIPT_DIR $HOME/.zsh
test ! -e $HOME/.home.zsh.bckp.${TS} || mv $HOME/.home.zsh.bckp.${TS} $HOME/.zsh/

test ! -e $HOME/.zshrc || mv $HOME/.zshrc $HOME/.zsh/.home.zshrc.bckp.${TS}
echo "== log: finish with OMZ"

echo "== log: init Homebrew"
if test ! $(which brew); then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/usr/local/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/usr/local/bin/brew shellenv)"
fi

brew update
brew tap homebrew/bundle
brew bundle --file $SCRIPT_DIR/Brewfile
echo "== log: finish with Homebrew"
