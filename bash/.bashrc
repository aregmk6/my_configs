#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# ------------------ my additions begin ------------------ 

## function overides
find2() { command find "$@" 2>/dev/null; }

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
    systemctl stop perimeter81helper.service
}

## aliases
alias t='tmux'
alias nv='nvim .'
alias preventsleep='systemd-inhibit --why="Manual sleep inhibit until turned off" --what=sleep sleep infinity'

## ssh
alias sshcougar='ssh -L 5902:localhost:5902 areg@gali_cougar'

## btctl aliases
alias btctl='bluetoothctl'
alias btair='btctl connect C0:B2:2F:82:53:B4'
alias btxm='btctl connect 88:C9:E8:07:59:ED'
alias btdis='btctl disconnect'

# PATH
export PATH="$HOME/bin:$PATH"


# yazi

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

export TERMINAL="kitty"
export EDITOR="nvim"
export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/docker.sock"

# ------------------  my additions end ------------------ 

# Created by `pipx` on 2026-07-06 11:56:01
export PATH="$PATH:/home/aregmk/.local/bin"

# ------------------  things that have to be at the bottom  ------------------ 
# zoxide
eval "$(zoxide init bash)"

# fzf
eval "$(fzf --bash)"
