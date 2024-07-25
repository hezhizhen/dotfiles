# dotfiles

I have been using [mackup][1] and [dropbox][2] to sync my configurations of CLIs and GUIs. Everything's fine, and I'll keep using them. I just want to save them here as a backup.

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
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
```

## Screenshots

These screenshots are stored in the [first issue][4] of this repository.

![desktop](https://github.com/user-attachments/assets/c6ac8278-5ec3-4a87-a0e0-d3bfc5ca8639)

[1]: https://github.com/lra/mackup
[2]: https://www.dropbox.com/
[4]: https://github.com/hezhizhen/dotfiles/issues/1
[5]: https://github.com/fatih/dotfiles/
