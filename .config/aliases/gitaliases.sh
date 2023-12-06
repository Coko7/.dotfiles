#!/bin/bash

alias gst='git status'

alias ga='git add'
alias gaa='git add --all'

alias gg='git grep -n'
alias gu='git grep -n --no-index'
function ggv() { git grep -n $1 | grep -v $2 | grep -n --color=always $1 | less; }
function grasp() { grep -inr "$1" --exclude-dir={obj,bin} --exclude=\*.min.\*; }

alias gp='git push'
alias gpo='git push origin'

#alias gr='git branch -r'
alias gb='git branch '
alias gbl='git branch --list'

#alias gc='git commit'

#alias gd='git diff --color=always | less -r'
function gd() { git diff "$@" --color=always | less -r; }
function gds() { git diff --staged "$@" --color=always | less -r; }

function gsh() { git show "$@" --color=always | less -r; }

#alias gco='git checkout '

#alias grs='git remote show'

# Log
function glo() { git log --pretty="oneline" "$@" --color=always | less -r ; }
function glol() { git log --graph --oneline --decorate "$@" --color=always | less -r; }
function gls() { git log --stat "$@" --color=always | less -r; }
function glg() { git log --graph "$@" --color=always | less -r; }

alias gpl='git pull'
alias gplo='git pull origin'

alias gstl='git stash list'

# Source Marco Fontani's custom git-grepblame command
# See: https://blog.darkpan.com/posts/git-grepblame/
source $HOME/scripts/git-grepblame.sh