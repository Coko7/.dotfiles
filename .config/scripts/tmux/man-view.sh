#!/usr/bin/env bash

pick=$(pacman -Q | cut -d' ' -f1 | fzf --exact \
    --prompt="Search MAN> " \
    --preview="man {} | bat --language=man --color=always --style=plain")

if [ -z "$pick" ]; then
    exit 0
fi

tmux neww bash -c "man $pick"
