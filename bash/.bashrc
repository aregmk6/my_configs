#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='\[\e[1;32m\]\u@\h \[\e[1;34m\]\w\[\e[0m\] \[\e[1;33m\]\n\$\[\e[0m\] '

# ------------------ my additions begin ------------------ 

## function overides
find() { command find "$@" 2>/dev/null; }
efind() { command find "$@"; }

fd() { command fd "$@" 2>/dev/null; }
efd() { command fd "$@"; }

rg() { command rg "$@" 2>/dev/null; }
erg() { command rg "$@"; }

nvim() {
    command nvim "$@";
    cd $(cat ~/.cache/nvim/last_cwd);
}

## new function
startdrive() {
    mkdir -p /home/aregmk/onedrive-local
    command rclone mount --daemon --vfs-cache-mode full onedrive: /home/aregmk/onedrive-local
}

stopdrive() {
    sudo umount /home/aregmk/onedrive-local
}

startsase() {
    sudo systemctl start perimeter81helper.service
    sleep 1
    perimeter81 &
}

stopsase() {
    sudo systemctl stop perimeter81helper.service
}

## ssh
alias sshcougar='ssh -L 5902:localhost:5902 areg@gali_cougar'

## aliases
alias tkill='tmux kill-server'
alias t='tmux'
alias vi='nvim'
alias nv='nvim .'
alias preventsleep='systemd-inhibit --why="Manual sleep inhibit until turned off" --what=sleep sleep infinity'
alias lisp='rlwrap sbcl'

## btctl aliases
alias btctl='bluetoothctl'
alias btair='btctl connect C0:B2:2F:82:53:B4'
alias btxm='btctl connect 88:C9:E8:07:59:ED'
alias btdis='btctl disconnect'

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

export TERMINAL="alacritty"
export EDITOR="nvim"
export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/docker.sock"

# Maximum number of lines contained in the history file
HISTFILESIZE=10000
# Number of commands to remember in the current shell session
HISTSIZE=10000
# turn off the annoying freeze of the terminal
stty -ixon

# ------------------  my additions end ------------------ 

# Created by `pipx` on 2026-07-06 11:56:01
# export PATH="$PATH:/home/aregmk/.local/bin"

# ------------------  things that have to be at the bottom  ------------------ 
# zoxide
eval "$(zoxide init bash)"

# fzf
eval "$(fzf --bash)"

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND='fd --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_ALT_C_COMMAND='fd --type d --strip-cwd-prefix --hidden --follow --exclude .git'

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
