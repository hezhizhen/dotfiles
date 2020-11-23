# General
set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
# Powerline
powerline-daemon -q
set POWERLINE_BASH_CONTINUATION 1
set POWERLINE_BASH_SELECT 1
set fish_function_path $fish_function_path "/usr/local/lib/python3.8/site-packages/powerline/bindings/fish"
powerline-setup
# Python
set PATH /usr/local/bin $PATH
set PATH ~/Library/Python/3.8/bin $PATH
# Golang
set -gx GOPATH ~/go
set PATH $GOPATH/bin $PATH
set PATH $PATH /usr/local/opt/go/libexec/bin
export GOPRIVATE=github.com/caicloud
set -gx GITHUBPATH $GOPATH/src/github.com
# Rust
set PATH ~/.cargo/bin $PATH
# Kubernetes
set -gx PATH $PATH $HOME/.krew/bin
# Autojump
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish
# Cheat
export CHEATCOLORS=true
