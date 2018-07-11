#### My struff

# Git
source ~/DevOps/git-repos/dot-files/.remove_merged_branches
source ~/DevOps/git-repos/dot-files/git-completion.bash

alias g='git'
alias ga='git add'
alias gl='git log'
alias gp='git pull'
alias gd='git diff'
alias gc='git commit'
alias gs='git status'
alias gst='git stash'
alias gpu='git push'
alias gco='git checkout'
alias gb='git checkout -b'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gpuoq='git push origin qa'

__git_complete gc _git_commit
__git_complete gp _git_pull
__git_complete gd _git_diff
__git_complete gst _git_stash
__git_complete gpu _git_push
__git_complete gco _git_checkout
