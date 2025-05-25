#!/usr/bin/env bash

pick=$(man -k . | cut -d' ' -f1 | sort -u | fzf --exact \
    --border-label ' Oskour-Man: Interactive Manual Fuzzer ' --input-label ' Input ' \
    --list-label ' Man Pages ' --preview-label ' Preview ' \
    --preview="man {} | bat -l man --color=always --style=plain")

if [ -z "$pick" ]; then
    exit 0
fi

tmux neww bash -c "man $pick"
