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
# Format: [user@host][SSH][cwd][git]$
# Check if session is over SSH
if [[ -n "$SSH_CONNECTION" ]]; then
    SSH_INDICATOR="%{$fg[red]%}[SSH]%{$reset_color%}"
else
    SSH_INDICATOR=""
fi

# Define git prompt components (same as robbyrussell theme)
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

# Custom prompt with git functionality from robbyrussell
PROMPT='%{$fg[cyan]%}%n@%m%{$reset_color%} ${SSH_INDICATOR} %{$fg[yellow]%}%~%{$reset_color%} $(git_prompt_info)%# '

# --- Systemd shortcut functions ---
alias status='sudo systemctl status'
alias start='sudo systemctl start'
alias stop='sudo systemctl stop'
alias restart='sudo systemctl restart'
alias enable='sudo systemctl enable'
alias disable='sudo systemctl disable'

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