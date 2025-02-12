# dotfiles

[![wakatime](https://wakatime.com/badge/user/9053a32c-e602-40ae-96b2-be7c43d90c66/project/018e1503-c7af-4ed1-8f23-e7a19646e9d3.svg)](https://wakatime.com/badge/user/9053a32c-e602-40ae-96b2-be7c43d90c66/project/018e1503-c7af-4ed1-8f23-e7a19646e9d3)
![last commit](https://img.shields.io/github/last-commit/hezhizhen/dotfiles)

This is the public version of my dotfiles.
It's also the base of dotfiles that I use on my working laptops.
I'll update it from time to time to keep it up-to-date.

## Installation

Credit to @fatih and his [dotfiles][5]

```shell
# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install all brew dependencies
brew bundle

# copy dotfiles to the appropriate places
make

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# open vim and install all plugins
:PlugInstall

# install doom emacs
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
```

## Screenshots

These screenshots are stored in the [first issue][4] of this repository.

![desktop](https://github.com/user-attachments/assets/c6ac8278-5ec3-4a87-a0e0-d3bfc5ca8639)

## CLIs

[version.csv](./version.csv)

[4]: https://github.com/hezhizhen/dotfiles/issues/1
[5]: https://github.com/fatih/dotfiles/
