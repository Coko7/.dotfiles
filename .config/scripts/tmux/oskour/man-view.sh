#!/usr/bin/env bash

pick=$(man -k . | cut -d' ' -f1 | sort -u | fzf --exact \
    --prompt="Search MAN> " \
    --preview="echo {} | figlet | lolcat -f -S 42")

if [ -z "$pick" ]; then
    exit 0
fi

tmux neww bash -c "man $pick"
