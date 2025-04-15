#!/usr/bin/env bash

pick=$(cheat --list \
    | tail -n +2 \
    | fzf --prompt="Search cheat> " --preview "cheat {1} | bat --color=always --plain --language=bash")
if [ -z "$pick" ]; then
    exit 0
fi

cheat_name=$(echo "$pick" | awk '{print $1}')
tmux neww bash -c "cheat $cheat_name | bat --color=always --paging=always --style=numbers --language=bash"
