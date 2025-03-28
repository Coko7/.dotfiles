#!/usr/bin/env bash

# dirs=$(cat $SCRIPTS/freq_dirs.txt | envsubst)
dirs=$(cat "$KIZ_WARP_LOC_A" | envsubst)

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find -H "$dirs" -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux neww -n "$selected_name" -c "$selected"
