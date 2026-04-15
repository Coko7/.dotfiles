#!/usr/bin/env bash

git_email=$(git config user.email)

[[ -z $git_email ]] && exit 1

fzf_args=(
  --border-label=' Commit Messages Fuzzy Finder '
  --input-label=' Input '
  --list-label=' Commit Messages '
  --preview-label=' Diff Preview '
  --delimiter=';'
  --with-nth=2
  --accept-nth="'{2}'"
  --preview='git show {1} | delta'
)

git log --author="$git_email" --pretty=format:"%h;%s" |
  fzf "${fzf_args[@]}"
