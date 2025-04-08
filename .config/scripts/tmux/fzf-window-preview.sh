#!/usr/bin/env bash

window_desc="$1"
window_id=$(echo "$1" | cut -d':' -f1)

echo "$window_desc"
echo -e "==============================\n" | lolcat -f -S 42

panes=$(tmux list-panes -t :"$window_id" | cut -d':' -f1)
for pane in $panes; do
    tmux capture-pane -pet ":${window_id}.${pane}"
done
