# General
set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8
set -g fish_user_paths /usr/local/sbin $fish_user_paths
# Python
set PATH /usr/local/bin $PATH
# Golang
set -gx GOPATH ~/go
set PATH $GOPATH/bin $PATH
set PATH $PATH /usr/local/opt/go/libexec/bin
# Rust
set PATH ~/.cargo/bin $PATH
# Kubernetes
set -gx PATH $PATH $HOME/.krew/bin
# Autojump
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish
# Cheat
export CHEATCOLORS=true
# Starship
starship init fish | source
