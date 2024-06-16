#!/usr/bin/env sh

TS=$(date "+%Y%m%d_%H%M%S")

SCRIPT_NAME="$(basename "$0")"
pushd $(dirname "$0") > /dev/null
SCRIPT_DIR=$(pwd)
popd > /dev/null

mkdir -p $SCRIPT_DIR/.bckp/$TS

echo "== log: setup OMZ: init"

test ! -e $HOME/.zshenv   || mv $HOME/.zshenv   $SCRIPT_DIR/.bckp/$TS/
test ! -e $HOME/.zsh      || mv $HOME/.zsh      $SCRIPT_DIR/.bckp/$TS/
test ! -e $HOME/.zshrc    || mv $HOME/.zshrc    $SCRIPT_DIR/.bckp/$TS/
test ! -e $HOME/.zprofile || mv $HOME/.zprofile $SCRIPT_DIR/.bckp/$TS/

cat > $HOME/.zshenv << '_EOF'
ZDOTDIR=$HOME/.zsh
_EOF

source $HOME/.zshenv
export ZDOTDIR=$ZDOTDIR

ln -s $SCRIPT_DIR $HOME/.zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
echo "== log: setup OMZ: done"

echo "== log: setup Homebrew: init"
if test ! $(which brew); then
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if test ! $(which brew); then
    echo "== err: setup Homebrew: installing brew with script from github failed; try to fix the issue and rerun this script; exiting"
    exit -1
  fi

  if test ! -e $ZDOTDIR/.zprofile ; then
    (echo; echo 'eval "$(/usr/local/bin/brew shellenv)"') > $ZDOTDIR/.zprofile
  fi

  eval "$(/usr/local/bin/brew shellenv)"

fi

brew update
brew tap homebrew/bundle
brew bundle --file $SCRIPT_DIR/Brewfile

echo "== log: setup Homebrew: done"
