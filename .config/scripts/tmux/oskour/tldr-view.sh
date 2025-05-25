#!/usr/bin/env bash

pick=$(tldr --list | fzf \
    --border-label ' Oskour-TLDR: Interactive TLDR Fuzzer ' --input-label ' Input ' \
    --list-label ' TLDR Entries ' --preview-label ' Preview ' \
    --preview "tldr --color always {1}")
if [ -z "$pick" ]; then
    exit 0
fi

tmux neww bash -c "tldr --color always $pick | less -R"
