#!/usr/bin/env bash

# Not very proud of this sourcing .zshrc but it works for now...

# shellcheck disable=SC1091
source "$ZDOTDIR/.zshrc"

working_dir=$(_ZO_DATA_DIR=$_ZO_DATA_DIR zoxide query --interactive)
if [ -n "$working_dir" ]; then
    window_name=$(basename "$working_dir")
    tmux new-window -c "$working_dir" -n "$window_name"
fi
