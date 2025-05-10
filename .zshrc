# -------------------------------
# ZSH Configuration File
# -------------------------------

# Set ZSH as your default shell
export SHELL=/usr/bin/zsh

# Path updates
export PATH="$HOME/bin:/usr/local/bin:$PATH"

# Oh My Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# Plugins
plugins=(
  git
  docker
  docker-compose
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Enable colors
autoload -U colors && colors

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Basic auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# --- Custom Prompt ---
# Format: [user@host][SSH][cwd]$
# Check if session is over SSH
if [[ -n "$SSH_CONNECTION" ]]; then
    SSH_INDICATOR="%{$fg[red]%}[SSH]%{$reset_color%}"
else
    SSH_INDICATOR=""
fi

# Prompt components
PROMPT='%{$fg[cyan]%}%n@%m%{$reset_color%} ${SSH_INDICATOR} %{$fg[yellow]%}%~%{$reset_color%} %# '

# --- Systemd shortcut functions ---
function status()  { systemctl status "$@" }
function start()   { systemctl start "$@" }
function stop()    { systemctl stop "$@" }
function restart() { systemctl restart "$@" }
function enable()  { systemctl enable "$@" }
function disable() { systemctl disable "$@" }

# --- Docker shortcuts ---
alias dc='docker compose'

# --- System aliases ---
alias cls='clear'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Source aliases
for file in ~/.dotfiles/aliases/*.sh; do
    if [ -f "$file" ]; then
        source "$file"
    fi
done

# Source private aliases if they exist
if [ -f ~/.dotfiles/aliases/private.sh ]; then
    source ~/.dotfiles/aliases/private.sh
fi

# --- Plugin Installation Instructions ---
# zsh-autosuggestions:
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
#
# zsh-syntax-highlighting:
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 