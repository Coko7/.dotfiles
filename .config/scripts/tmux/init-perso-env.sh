#!/usr/bin/env bash

session_name="Perso-Mux"
ws_type="PERSO"
todo_path="$PROJ_PERSO/Notes/todo-log"

# If session does not exist, set it up
if ! tmux has-session -t "$session_name" 2>/dev/null; then
    # Create new session (detached) and set name, custom env var, working dir and rename window
    tmux new-session -d -s "$session_name" -e TMUX_WS_TYPE="$ws_type" -c "$todo_path"

    # Windows 1 (Left): TODO
    tmux rename-window -t "$session_name:1" "$ws_type TODO"
    tmux send-keys -t "$session_name" 'vim todo.md' C-m

    # Window 1 (Right): Backlog
    tmux split-window -h -c "#{pane_current_path}" -t "$session_name"
    tmux send-keys -t "$session_name" 'vim backlog.md' C-m

    # Window 2: dotfiles
    tmux new-window -c "$HOME/dotfiles" -n "dotfiles"

    # Window 3: TLS from scratch
    tmux new-window -c "$PROJ_PERSO/Programming/rust/web/rtw-tls-rs" -n "tls-fs"

    # Go to first window
    tmux select-window -t 1
fi
