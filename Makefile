all: sync

sync:
	mkdir -p ~/.config/alacritty

	[ -f ~/.config/alacritty/alacritty.yml ] || ln -s $(PWD)/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
	[ -f ~/.vimrc ] || ln -s $(PWD)/.vimrc ~/.vimrc
	[ -f ~/.gitconfig ] || ln -s $(PWD)/.gitconfig ~/.gitconfig
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/.tmux.conf ~/.tmux.conf
	[ -f ~/.config/starship.toml ] || ln -s $(PWD)/.config/starship.toml ~/.config/starship.toml
	[ -f ~/.yabairc ] || ln -s $(PWD)/.yabairc ~/.yabairc
	[ -f ~/.skhdrc ] || ln -s $(PWD)/.skhdrc ~/.skhdrc
	[ -d ~/.config/nvim ] || ln -s $(PWD)/.config/nvim ~/.config/nvim

clean:
	rm -f ~/.config/alacritty/alacritty.yml
	rm -f ~/.vimrc
	rm -f ~/.gitconfig
	rm -f ~/.tmux.conf
	rm -f ~/.config/starship.toml
	rm -f ~/.yabairc
	rm -f ~/.skhdrc
	rm -rf ~/.config/nvim

.PHONY: all clean sync build run kill
