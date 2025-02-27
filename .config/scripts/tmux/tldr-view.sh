#!/usr/bin/env bash

pick=$(tldr --list | fzf --prompt="Search TLDR> " --preview "tldr --color always {1}")
if [ -z "$pick" ]; then
    exit 0
fi

tmux neww bash -c "tldr --color always $pick | less -R"
