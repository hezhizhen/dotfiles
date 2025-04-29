if status is-interactive
    # Commands to run in interactive sessions can go here
end

# General
set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8
set -g fish_user_paths /opt/homebrew/bin $fish_user_paths
set -g fish_user_paths /opt/homebrew/sbin $fish_user_paths

# merge fish history across sessions
abbr -a hr 'history --merge'

if type -q bat
    function hp -d "highlight help messages with `bat`"
        argparse --min-args 1 h/help -- $argv
        or return
        $argv --help 2>&1 | bat --plain --language=help
    end
end

# colored man output
# from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
setenv LESS_TERMCAP_mb \e'[01;31m' # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;74m' # begin bold
setenv LESS_TERMCAP_me \e'[0m' # end mode
setenv LESS_TERMCAP_se \e'[0m' # end standout-mode
setenv LESS_TERMCAP_so \e'[38;5;246m' # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m' # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline

# Languages
# Go
set -gx GOPATH ~/go
set PATH $GOPATH/bin $PATH
# Rust
set PATH ~/.cargo/bin $PATH

# Tools
# Atuin
atuin init fish | source
# Autojump
[ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish
# Curl
fish_add_path /opt/homebrew/opt/curl/bin
# for compilers
set -gx LDFLAGS -L/opt/homebrew/opt/curl/lib
set -gx CPPFLAGS -I/opt/homebrew/opt/curl/include
# for pkg-config
set -gx PKG_CONFIG_PATH /opt/homebrew/opt/curl/lib/pkgconfig
# WakaTime
set PATH $PATH ~/.wakatime
# Cheat
export CHEATCOLORS=true
# Kubernetes
set -gx PATH $PATH $HOME/.krew/bin
# Starship
starship init fish | source

# Scripts
set -gx SCRIPTSPATH $HOME/scripts
set PATH $PATH $SCRIPTSPATH

test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish
uv generate-shell-completion fish | source
uvx --generate-shell-completion fish | source
