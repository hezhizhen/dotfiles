# dotfiles

I have been using [mackup][1] and [dropbox][2] to sync my configurations of CLIs and GUIs. Everything's fine, and I'll keep using them. I just want to save them here as a backup.

## What I use

- [alacritty](.config/alacritty)
- [emacs](.doom.d)
- [finicky](.finicky.js)
- [fish](.config/fish)
- [git](.gitconfig)
- [jrnl](.config/jrnl)
- [vim](.vimrc)
- [tmux](.tmux.conf)

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

### vim

![vim](https://user-images.githubusercontent.com/7611700/102567433-77384c00-411c-11eb-81d1-81f1c98a5915.png)

### fish

![](https://user-images.githubusercontent.com/7611700/185289386-089984a2-798d-4347-af97-217b5760da7c.png)

- [starship][3]

[1]: https://github.com/lra/mackup
[2]: https://www.dropbox.com/
[3]: https://starship.rs/
[4]: https://github.com/hezhizhen/dotfiles/issues/1
[5]: https://github.com/fatih/dotfiles/
