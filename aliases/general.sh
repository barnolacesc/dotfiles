# General aliases
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# System
alias update='sudo apt update'
alias upgrade='sudo apt upgrade'
alias clean='sudo apt autoremove'
alias ports='netstat -tulanp'
alias mkdir='mkdir -pv'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowdate='date +"%d-%m-%Y"'

# Development
alias py='python3'
alias pip='pip3'
alias serve='python3 -m http.server 8000'
alias activate='source venv/bin/activate'

# Process management
alias ps='ps auxf'
alias top='htop'
alias mem='free -h'
alias cpu='lscpu'

# Network
alias myip='curl http://ipecho.net/plain; echo'
alias localip='hostname -I | awk "{print \$1}"'
alias header='curl -I'

# Safety
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'

# Quick edit
alias zshconfig='vi ~/.zshrc'
alias ohmyzsh='vi ~/.oh-my-zsh'

# Directory shortcuts
alias home='cd ~'
alias desktop='cd ~/Desktop'
alias documents='cd ~/Documents'
alias downloads='cd ~/Downloads' 
alias repos='cd ~/repos'