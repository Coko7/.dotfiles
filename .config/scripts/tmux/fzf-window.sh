#!/usr/bin/env bash

# sessions=$(tmux list-sessions | cut -d':' -f1)
# for session in $sessions; do
#     # windows=$(tmux list-windows -t "$session")
#     windows=$(tmux list-windows)
#     tmux display-popup "echo -e '$windows' | fzf"
# done

preview_script="$SCRIPTS/tmux/fzf-window-preview.sh"

windows=$(tmux list-windows -F '#I: #{window_name} (#{window_panes}p)')
pick=$(echo -e "$windows" \
    | fzf-tmux -p -w 80% -h 80% --prompt="Search window> " --preview="$preview_script {}" \
    | cut -d':' -f1)

if [ -n "$pick" ]; then
    tmux select-window -t "$pick"
fi
