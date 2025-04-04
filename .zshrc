# Enable colors and change prompt
autoload -U colors && colors
PS1='%F{green}%n%f@%F{blue}%m%f %F{yellow}%~%f %# '

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

# Load aliases
for file in $HOME/.dotfiles/aliases/*.sh; do
    [ -f "$file" ] && source "$file"
done

# Useful aliases
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'

# Directory shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git shortcuts
alias g='git'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gs='git status'

# System
alias update='sudo apt update'
alias upgrade='sudo apt upgrade'
alias clean='sudo apt autoremove' 