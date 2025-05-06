#!/usr/bin/env bash

session="$1"
window_count=$(tmux display-message -p -t "$session" '#{session_windows}')

echo "$session (windows: $window_count)"
echo -e "==============================\n" | lolcat -f -S 42

tmux list-windows -t "$session" -F '#I: #{window_name} (#{window_panes} panes)' | while read -r idx window; do
  echo "$idx $window"
done
