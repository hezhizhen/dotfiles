all: sync

sync:
	[ -d ~/.doom.d ]     || ln -s $(PWD)/.doom.d     ~/.doom.d
	[ -f ~/.finicky.js ] || ln -s $(PWD)/.finicky.js ~/.finicky.js
	[ -f ~/.gitconfig ]  || ln -s $(PWD)/.gitconfig  ~/.gitconfig
	[ -f ~/.tmux.conf ]  || ln -s $(PWD)/.tmux.conf  ~/.tmux.conf
	[ -f ~/.vimrc ]      || ln -s $(PWD)/.vimrc      ~/.vimrc
	[ -f ~/.yabairc ]    || ln -s $(PWD)/.yabairc    ~/.yabairc

	[ -d ~/.config ] || ln -s $(PWD)/.config ~/.config

clean:
	rm -rf ~/.doom.d
	rm -f ~/.finicky.js
	rm -f ~/.gitconfig
	rm -f ~/.tmux.conf
	rm -f ~/.vimrc
	rm -f ~/.yabairc

	rm -f ~/.config

update: brew spell

brew:
	brew upgrade
	mas upgrade
	brew bundle dump --describe --force

spell:
	typos

.PHONY: all clean sync brew spell update
