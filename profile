#!/bin/bash

###############################################
# Default editor
export EDITOR="vim"
# History enhanced GaboFDC
export HISTTIMEFORMAT="[%F %T] "
export HISTFILESIZE=
export HISTSIZE=
export HISTCONTROL=ignoredups
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend
# After each command, append to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# Nice prompt
PS1='\[\033[0;31m\]\t\[\033[0m\] \[\033[0;36m\] [\u@\h]\[\033[0m\]\[\033[0;34m\] \w \[\033[0m\] \$ '

# Proper pager
export PAGER=less
export LESS="-iMSx4 -FX"

###############################################
##### Alias enhanced GaboFDC
# shellcheck source=/dev/null
source /etc/os-release

### General
alias ls='ls --color'
alias ll="ls -lhA"
alias lll='ls -lhatr'
alias diff='vimdiff'
alias yum='sudo yum'
alias dnf='sudo dnf'
alias grep='egrep --color'
alias pgrep='\grep --color -P'
alias df='df -h -x squashfs'
alias ports='netstat -tupanl'
alias fastping='ping -c 100 -s.2'
alias ipcalc='/opt/ipcalc-0.41/ipcalc'

# Miss type
alias grpe='grep'
alias les='less'


# Parenting changing perms on / #
alias rsync='rsync -rav --progress --stats'
alias myip='curl ifconfig.co'
function hhistory {
    history |awk -F']' '{print $2}' |uniq
}
function stats {
    history | awk '{CMD[$4]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -n
}

function ms {
    date -d @$(  echo "($1 + 500) / 1000" | bc)
}
# Devel
alias tf='terraform'
alias pireq='pip install -r requirements.txt'
alias nenv='python3 -m venv .env'
alias aenv='source .env/bin/activate'
alias cdkfile='cdk synth > template-$(date +%F-%T).yml'
cdkdeploy(){
    cdk diff "$@"
    echo
    read -rp "continue (y/N)"
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        cdk deploy "$@"
    fi
}

### MAC
if [ "$ID" == "mac" ]; then # Review
    alias ls='ls -G'
    alias ip='ifconfig -a'
    alias flushdns='sudo dscacheutil -flushcache'
fi

### Ubuntu
if [ "$ID" == "ubuntu" ]; then # Review
    alias pip='pip3'
    alias apt='sudo apt'
    alias yum='sudo apt-get'
    alias dnf='sudo apt-get'
    alias apt-get='sudo apt-get'
fi
