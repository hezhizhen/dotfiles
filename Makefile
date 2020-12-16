all: sync

sync:
	[ -f ~/.vimrc ] || ln -s $(PWD)/.vimrc ~/.vimrc # vim

clean:
	rm -f ~/.vimrc                                  # vim

.PHONY: all clean sync build run kill
