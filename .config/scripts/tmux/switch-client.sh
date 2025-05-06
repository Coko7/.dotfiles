#!/usr/bin/env bash

function toggle-switch() {
    current_session=$(tmux display-message -p '#S')
    other_session=$(tmux list-sessions -F "#{session_name}" | fzf -f "!$current_session")
    tmux switch-client -t "$other_session"
}

function fuzzy-switch() {
    preview_script="$SCRIPTS/tmux/fzf-session-preview.sh"
    sessions=$(tmux list-sessions -F "#{session_name}")
    pick=$(echo -e "$sessions" \
        | fzf-tmux -p -w 50% -h 50% \
        --prompt="Select session> " \
        --preview="$preview_script {}")

    if [ -n "$pick" ]; then
        tmux switch-client -t "$pick"
    fi
}

SESSION_COUNT=$(tmux list-sessions | wc -l)

case $SESSION_COUNT in
    0) echo "No tmux server running" >&2; exit 1 ;;
    1) exit 0 ;;
    2) toggle-switch; exit 0 ;;
    *) fuzzy-switch; exit 0 ;;
esac
