## One more attempt to aproach to `dot files` for **macOS** with **OMZ** and **brew**

### Main idea

* The ideas behind this approach are:
  * Use the repo as a source to initialize just installed **macOS** with **OMZ** and **brew**
  * Use the same repo as _Zsh dotfiles directory_
  * Have minimalistic set of configuration files
  * Make initiallization script idempotent, to be able to run in any time to installation and uppgrade
* The idea is based on [driesvints/dotfiles](https://github.com/driesvints/dotfiles)

### Requirements

For the just installed macOS `git` should be installed beforehand to be able to clone this repo

### Installation

To install (fresh) or upgrade (existing) macOS `dot files` configuration use the following steps

1. Clone the repo into `$HOME/.dotfiles` directory

```console
git clone https://github.com/aws-simple/dotfiles.git $HOME/.dotfiles
```

2. Run the `install.sh` script from the cloned directory

```console
$HOME/.dotfiles/install.sh
```
