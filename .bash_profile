#### My struff

# Git
source ~/GIT/dot-files/.remove_merged_branches
source ~/GIT/dot-files/git-completion.bash

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
alias gll='git log  --oneline -n 10'
alias glll='git log  --oneline -n 30'

__git_complete gc _git_commit
__git_complete gp _git_pull
__git_complete gd _git_diff
__git_complete gso _git_show
__git_complete gst _git_stash
__git_complete gpu _git_push
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
    fi
}

# cd and gs calls autofetch

function cd {
    builtin cd "$@"
    auto_fetch
}

function gs {
    auto_fetch
    sleep 3
    git status "$@"
}

# Git branch creation and setup upstream
function gb {
    git checkout -b "$@"
    git push --set-upstream origin "$@"
}
