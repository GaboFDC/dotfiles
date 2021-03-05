#!/bin/bash
#### My struff

# Git
# shellcheck source=/dev/null
source ~/GIT/dotfiles/.remove_merged_branches
source ~/GIT/dotfiles/git-completion.bash

# AWS CLI Completer
complete -C 'aws_completer' aws

GIT_FETCH_INTERVAL=${GIT_FETCH_INTERVAL:=600}

alias g='git'
alias ga='git add'
alias gl='git log'
alias gp='git pull'
alias gd='git diff'
alias gc='git commit'
# Moved to funciton
#alias gs='git status'
alias gso='git show'
alias gst='git stash'
alias gpu='git push'
alias gco='git checkout'
# Moved to funciton
#alias gb='git checkout -b'
alias gcp='git cherry-pick'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gpuoq='git push origin qa'
alias grs='git restore --staged'
alias gll='git log  --oneline -n 10'
alias glll='git log  --oneline -n 30'

__git_complete gb _git_branch
__git_complete gp _git_pull
__git_complete gd _git_diff
__git_complete gc _git_commit
__git_complete gpu _git_push
__git_complete gso _git_show
__git_complete gst _git_stash
__git_complete gco _git_checkout
__git_complete gcp _git_cherry_pick


git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global pull.rebase true

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

function cd {
    builtin cd "$@" || return
    auto_fetch
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

# Play sound on long commands finish:
if grep -qi Microsoft /proc/version; then
    trap '_T=${_T:-$SECONDS}' DEBUG
    PROMPT_COMMAND='
        history -a; history -c; history -r;
        ((SECONDS - _T > 300)) &&
            { powershell.exe "[System.Console]::Beep(247,200);[System.Console]::Beep(220,200);[System.Console]::Beep(196,200);[System.Console]::Beep(220,200);[System.Console]::Beep(247,200);[System.Console]::Beep(247,200);[System.Console]::Beep(247,400);[System.Console]::Beep(220,200);[System.Console]::Beep(220,200);[System.Console]::Beep(220,400);;[System.Console]::Beep(247,200);[System.Console]::Beep(294,200);[System.Console]::Beep(294,400)";};
        unset _T;
    '
fi

# export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}; $PROMPT_COMMAND_SOUND"

