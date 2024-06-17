#!/bin/bash
#### My struff

# Git
# shellcheck source=/dev/null
source ~/GIT/dotfiles/.remove_merged_branches
source ~/GIT/dotfiles/git-completion.bash

# Podman > Docker
alias docker='podman'
alias d='podman'
alias p='podman'

# AWS CLI Completer
complete -C 'aws_completer' aws

# In Seconds. Default 60 Mins
GIT_FETCH_INTERVAL=${GIT_FETCH_INTERVAL:=3600}

# tf
complete -C /usr/bin/terraform terraform

# k8s
alias k=kubectl
source <(kubectl completion bash)
complete -F __start_kubectl k


alias g='git'
__git_complete g _git
alias ga='git add'
__git_complete ga _git_add
alias gl='git log'
alias gll='git log  --oneline -n 10'
alias glll='git log  --oneline -n 30'
__git_complete gl _git_log
alias gp='git pull'
__git_complete gp _git_pull
alias gd='git diff'
__git_complete gd _git_diff
#alias gc='git commit'
alias gca='git commit --amend --no-edit'
__git_complete gc _git_commit
# Moved to funciton
#alias gs='git status'
__git_complete gs _git_status
alias gso='git show'
__git_complete gso _git_show
alias gst='git stash'
alias gstl='git stash list'
alias gstp='git stash pop'
__git_complete gst _git_stash
alias gpu='git push'
alias gpuoq='git push origin qa'
__git_complete gpu _git_push
alias gco='git checkout'
__git_complete gco _git_checkout
# Moved to funciton
#alias gb='git checkout -b'
alias gbr='git branch'
__git_complete gbr _git_branch
alias gcp='git cherry-pick'
__git_complete gcp _git_cherry_pick
alias grs='git restore --staged'


# Autofetch function, called on cd and gs
# Ref from https://github.com/ohmyzsh/ohmyzsh/pull/5477/files

function auto_fetch {
    dir=$(git rev-parse --git-dir 2>/dev/null)
    last_fetch=$(date -r "$dir"/FETCH_LOG +%s 2>/dev/null || echo 0)
    if [[ $dir ]] && (( $(date +%s) - last_fetch > GIT_FETCH_INTERVAL )); then
       git fetch --all &> "$dir"/FETCH_LOG &
       sleep 3
    fi
}

# cd and gs calls autofetch
# also, save cd history
function cd {
    if [[ "$@" != "" && "$@" != "-" ]]; then
        REAL="$(realpath -Ls "$@")"
        if [[ $REAL == "/mnt/c/Users/Gabriel_Diaz/OneDrive - EPAM/GIT/"* ]];then
            D="${REAL/'/mnt/c/Users/Gabriel_Diaz/OneDrive - EPAM/GIT'/"/home/wsl/GIT"}"
        else
            D="$REAL"
        fi
        pushd -n $D &> /dev/null
    fi
    builtin cd "$@" || return
    auto_fetch
}

# Nicer dirs for long paths
alias dirs='dirs | tr " " "\n" | nl -v 0'
# cd to old dir quickly
function cdd {
    if [[ $# -eq 1 && $1 =~ ^[0-9] ]]; then
        cd "$(\dirs -l +$1)"
    else
        echo "Wrong ussage. Use cdd N"
    fi
}

function gs {
    auto_fetch
    git status "$@"
}

# Git branch creation and setup upstream
function gb {
    git checkout -b "$@"
    git push --set-upstream origin "$@"
}

# Count commit message lenght
function gc {
    if [[ $# -eq 2 && $1 == "-m" ]]; then
        len=$(echo "$2" | wc -c)
        echo "Commimt message lenght: $len"
        read -p "Continue commit? (y/n): " cont
        if [[ "$cont" != "y" ]]; then
            echo "Aborting..."
            return
        fi
    fi
    git commit "$@"
}

# Change current pwd to use synlink if exists
function lnswitch {
    for link in $(sudo find ~ -type l -not -path '*/.*'); do
        DEST="$(readlink -f $link)"
        if [[ $PWD == $DEST* ]]; then
            cd ${PWD/$DEST/$link}
        fi
    done
}

function hdu {
    sudo du -khsc "$@".[!.]*
}

# Save working dir for windows terminal
PROMPT_COMMAND=${PROMPT_COMMAND:+"$PROMPT_COMMAND; "}'printf "\e]9;9;%s\e\\" "$PWD"'


# Play sound on long commands finish:
if grep -qi Microsoft /proc/version; then
    trap '_T=${_T:-$SECONDS}' DEBUG
    PROMPT_COMMAND_SOUND='
        ((SECONDS - _T > 300)) &&
            { powershell.exe "[System.Console]::Beep(247,200);[System.Console]::Beep(220,200);[System.Console]::Beep(196,200);[System.Console]::Beep(220,200);[System.Console]::Beep(247,200);[System.Console]::Beep(247,200);[System.Console]::Beep(247,400);[System.Console]::Beep(220,200);[System.Console]::Beep(220,200);[System.Console]::Beep(220,400);;[System.Console]::Beep(247,200);[System.Console]::Beep(294,200);[System.Console]::Beep(294,400)";};
        unset _T
    '
fi

export PROMPT_COMMAND=${PROMPT_COMMAND:+"$PROMPT_COMMAND; "}"$PROMPT_COMMAND_SOUND"

# Load last directory
#function lastdir {
#    [ -s ~/.lastdirectory  ] && cd $(cat ~/.lastdirectory)
#}


# Daily fortune cookie
MOOD="bdgpstwy"
RAND_MOOD=${MOOD:$(shuf -i 0-$((${#MOOD}-1)) -n1):1}
fortune | cowsay -n -$RAND_MOOD
#lastdir
lnswitch
