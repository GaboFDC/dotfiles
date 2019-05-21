#### My struff

# Git
source ~/GIT/dot-files/.remove_merged_branches
source ~/GIT/dot-files/git-completion.bash

alias g='git'
alias ga='git add'
alias gl='git log'
alias gp='git pull'
alias gd='git diff'
alias gc='git commit'
alias gs='git status'
alias gso='git show'
alias gst='git stash'
alias gpu='git push'
alias gco='git checkout'
alias gb='git checkout -b'
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
