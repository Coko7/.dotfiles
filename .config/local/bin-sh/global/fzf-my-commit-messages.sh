#!/usr/bin/env bash

git_user=$(git config user.name)

[[ -z $git_user ]] && exit 1

fzf_args=(
    --border-label ' Commit Messages Fuzzy Finder '
    --input-label ' Input '
    --list-label ' Commit Messages '
    --preview-label ' Diff Preview '
    --delimiter ';'
    --with-nth '{2}'
    --accept-nth "'{2}'"
    --preview 'git show {1} | delta'
)

git log --author="$git_user" --pretty=format:"%h;%s" | fzf "${fzf_args[@]}"
