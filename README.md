# dotfiles

I have been using [mackup][1] and [dropbox][2] to sync my configurations of CLIs and GUIs. Everything's fine, and I'll keep using them. I just want to save them here as a backup.

## Vim

![screenshot](.media/vim.png)

Location: [`~/.vimrc`](./.vimrc)

- Install [MacVim][3]: `brew install macvim`
- Font: DroidSansMono Nerd Font (12)

## Fish

![screenshot](.media/fish.png)

Location: [~/.config/fish/](./.config/fish/)

```
.
├── completions
│  ├── kubectl.fish
│  └── minikube.fish
├── config.fish
├── fish_variables
└── functions
   ├── fetch-upstream.fish
   ├── fish_greeting.fish
   ├── fish_user_key_bindings.fish
   ├── fzf_key_bindings.fish ⇒ /usr/local/opt/fzf/shell/key-bindings.fish
   └── set-upstream.fish
```

### Starship

Location: [`~/.config/starship.toml`](./.config/starship.toml)

- Install [Starship][4]: `cargo/brew install starsip`

## Git

Location: [`~/.gitconfig`](./.gitconfig)

[1]: https://github.com/lra/mackup
[2]: https://www.dropbox.com/
[3]: https://macvim-dev.github.io/macvim/
[4]: https://starship.rs
