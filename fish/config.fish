set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8

powerline-daemon -q
set POWERLINE_BASH_CONTINUATION 1
set POWERLINE_BASH_SELECT 1
set fish_function_path $fish_function_path "/usr/local/lib/python3.7/site-packages/powerline/bindings/fish"
powerline-setup

set -gx GOPATH ~/go/
set PATH $GOPATH/bin $PATH
set PATH $PATH /usr/local/opt/go/libexec/bin
[ -f /usr/local/share/autojump/autojump.fish ]
and source /usr/local/share/autojump/autojump.fish

set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8

export CHEATCOLORS=true

set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
