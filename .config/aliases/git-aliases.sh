#!/bin/bash

# Pull
alias gpl='git pull'
alias gplo='git pull origin'

# Status
alias gst='git status'

# Diff / show
alias gd='git diff'
alias gdw='git diff --word-diff'
alias gds='git diff --staged'
#function gd() { git diff --color=always "$@" | less -r; }
#function gds() { git diff --color=always --staged "$@" | less -r; }
alias gsh='git show'
#function gsh() { git show "$@" --color=always | less -r; }

# Add / stage
alias ga='git add'
alias gaa='git add --all'

# Commit
alias gc='git commit'
alias gca='git commit --amend'
alias gcm='git commit -m'

# Push
alias gp='git push'
alias gpo='git push origin'

# Grep
alias gg='git grep -n'
alias gu='git grep -n --no-index'
function ggv() { git grep -n $1 | grep -v $2 | grep -n --color=always $1 | less; }
function grasp() { grep -inr "$1" --exclude-dir={obj,bin} --exclude=\*.min.\*; }

# Branch
#alias gr='git branch -r'
alias gb='git branch'
alias gbl='git branch --list'
alias gco='git checkout'
alias gcb='git checkout -b'
#alias grs='git remote show'

# Log
alias glo='git log --pretty="oneline"'
alias glol='git log --graph --oneline --decorate'
alias gls='git log --stat'
alias glg='git log --graph'
#function glo() { git log --pretty="oneline" "$@" --color=always | less -r; }
#function glol() { git log --graph --oneline --decorate "$@" --color=always | less -r; }
#function gls() { git log --stat "$@" --color=always | less -r; }
#function glg() { git log --graph "$@" --color=always | less -r; }
alias glgp="git log --graph --abbrev-commit --decorate --format=format:'%C(bold green)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold yellow)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"

# Stash
alias gstl='git stash list'
