# Lines configured by zsh-newuser-install
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/aregmk/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# History settings
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.zsh_history"
setopt SHARE_HISTORY          # Share history between sessions
setopt HIST_IGNORE_DUPS       # Ignore duplicate commands

# Prompt: user@host dir \n $ (matching your Bash colors)
# %F{...} sets foreground color, %f resets it
PS1='%F{green}%n@%m %F{blue}%~%f
%F{yellow}%#%f '

# Disable terminal flow control (unfreezes Ctrl+S / Ctrl+Q)
stty -ixon 2>/dev/null

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias sshcougar='ssh -L 5902:localhost:5902 areg@gali_cougar'
alias tkill='tmux kill-server'
alias t='tmux'
alias vi='nvim'
alias nv='nvim .'
alias preventsleep='systemd-inhibit --why="Manual sleep inhibit until turned off" --what=sleep sleep infinity'
alias lisp='rlwrap sbcl'

# Bluetooth
alias btctl='bluetoothctl'
alias btair='btctl connect C0:B2:2F:82:53:B4'
alias btxm='btctl connect 88:C9:E8:07:59:ED'
alias btdis='btctl disconnect'

# Overrides
find()  { command find "$@" 2>/dev/null; }
efind() { command find "$@"; }
fd()    { command fd "$@" 2>/dev/null; }
efd()   { command fd "$@"; }
rg()    { command rg "$@" 2>/dev/null; }
erg()   { command rg "$@"; }

nvim() {
    command nvim "$@"
    if [ -f "$HOME/.cache/nvim/last_cwd" ]; then
        cd "$(< "$HOME/.cache/nvim/last_cwd")"
    fi
}

# Service & mount management
startdrive() {
    mkdir -p "$HOME/onedrive-local"
    command rclone mount --daemon --vfs-cache-mode full onedrive: "$HOME/onedrive-local"
}

stopdrive() {
    sudo umount "$HOME/onedrive-local"
}

startsase() {
    sudo systemctl start perimeter81helper.service
    sleep 1
    perimeter81 &
}

stopsase() {
    sudo systemctl stop perimeter81helper.service
}

# Yazi (Official Zsh wrapper)
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    command yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# PATH
add_path() {
    if [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$1:$PATH"
    fi
}
add_path "$HOME/bin"
add_path "$HOME/.local/bin"

# Other Exports

export TERMINAL="alacritty"
export EDITOR="nvim"
export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/docker.sock"

# FZF default commands
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND='fd --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_ALT_C_COMMAND='fd --type d --strip-cwd-prefix --hidden --follow --exclude .git'

# Tool Integrations (Zsh native initialization)
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

source /home/aregmk/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^ ' autosuggest-accept
