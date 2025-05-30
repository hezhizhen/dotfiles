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

| CLI                                                   | Path                        | Version            |
| ----------------------------------------------------- | --------------------------- | ------------------ |
| [AeroSpace](https://github.com/nikitabobko/AeroSpace) | /opt/homebrew/bin/aerospace | 0.17.0-Beta        |
| [fish](https://fishshell.com/)                        | /opt/homebrew/bin/fish      | 4.0b1              |
| [Git](https://git-scm.com/)                           | /opt/homebrew/bin/git       | 2.48.1             |
| [Homebrew](https://brew.sh/)                          | /opt/homebrew/bin/brew      | 4.4.21-31-gdf70c9f |
| [Neovim](https://neovim.io/)                          | /opt/homebrew/bin/nvim      | 0.10.4             |
| [typos](https://github.com/crate-ci/typos)            | /opt/homebrew/bin/typos     | 1.29.7             |
| [Visual Studio Code](https://code.visualstudio.com/)  | /opt/homebrew/bin/code      | 1.97.2             |

[CSV](version.csv)

[4]: https://github.com/hezhizhen/dotfiles/issues/1
[5]: https://github.com/fatih/dotfiles/
