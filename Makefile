all: sync

define check_dir_and_link
	@if [ -d $(2) ]; then \
		if [ -L $(2) ]; then \
			if [ "$$(readlink $(2))" = "$(1)" ]; then \
				echo "Directory $(2) is already linked to $(1). Skipping..."; \
			else \
				echo "Directory $(2) is linked to $$(readlink $(2)). Aborting..."; \
			fi; \
		else \
			mv $(1) $(1).bak; \
			mv $(2) $(1); \
			ln -s $(1) $(2); \
		fi; \
	else \
		echo "Directory $(2) does not exist. Skipping..."; \
	fi
endef

define check
	echo $(1)
	echo $(2)
endef

test:
	$(call check,$$(pwd),$(HOME))
	$(call check_dir_and_link,$$(pwd)/.config/alacritty,$(HOME)/.config/alacritty)

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
	typos --format=brief

start-bukuserver:
	BUKUSERVER_THEME=united BUKUSERVER_DISABLE_FAVICON=false BUKUSERVER_OPEN_IN_NEW_TAB=true bukuserver run --debug

.PHONY: all clean sync brew spell update test
