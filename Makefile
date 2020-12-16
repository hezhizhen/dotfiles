all: sync

sync:
	mkdir -p ~/.config/alacritty

	[ -f ~/.config/alacritty/alacritty.yml ] || ln -s $(PWD)/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
	[ -f ~/.vimrc ] || ln -s $(PWD)/.vimrc ~/.vimrc

clean:
	rm -f ~/.config/alacritty/alacritty.yml
	rm -f ~/.vimrc

.PHONY: all clean sync build run kill
