#!/usr/bin/env bash

function select_monitor() {
    query="$1"
    monitor=$(list-hypr-monitors.sh \
        | fzf --accept-nth=1 --header="Yeet Query: $query" \
        --height=40% --tmux=40% --list-label ' Monitors ' \
        --border-label ' Interactive Workspace Dispatcher ' --input-label ' Input ')

    [[ -z "$monitor" ]] && exit 1
    if ! gum confirm "Do you want to dispatch workspace $query to $monitor ?"; then
        exit 1
    fi

    echo "$monitor"
}

function yeet_ws_to_monitor() {
    workspace_id="$1"
    monitor="$2"

    [[ -n "$workspace_id" ]] || { echo "expects workspace_id"; exit 1; }
    [[ -n "$monitor" ]] || { echo "expects monitor"; exit 1; }

    if hyprctl workspaces -j | jq --argjson ws_id "$workspace_id" \
        --exit-status '.[] | select(.id == $ws_id)' > /dev/null; then

        echo "🦘 Yeeting workspace $workspace_id to: $monitor"
        hyprctl dispatch moveworkspacetomonitor "$workspace_id" "$monitor"
    else
        echo "Workspace not active: $workspace_id. Skipping..."
    fi
}

function handle_range() {
    start=$1
    end=$2

    if [[ "$start" -gt "$end" ]]; then
        echo "start: $start"
        echo "end: $end"
        echo "error: start must be less than or equal to end" >&2
        exit 1
    fi

    monitor=$(select_monitor "$start-$end")
    [[ -n "$monitor" ]] || exit 1

    for i in $(seq "$start" "$end"); do
        yeet_ws_to_monitor "$i" "$monitor"
    done
}

function handle_single_num() {
    workspace_id="$1"

    monitor=$(select_monitor "$workspace_id")
    [[ -n "$monitor" ]] || exit 1

    yeet_ws_to_monitor "$workspace_id" "$monitor"
}

workspaces=$(seq --separator=", " 1 10)
echo "All workspaces: $workspaces"

selection_query=$(gum input --prompt="Query workspaces> " --value="1-9,10" --placeholder="1-5,6,7-8...")
[[ -n "$selection_query" ]] || { exit 1; }

IFS=',' read -ra items <<< "$selection_query"
for item in "${items[@]}"; do

    if [[ "$item" =~ ^([0-9])-([0-9])$ ]]; then
        start="${BASH_REMATCH[1]}"
        end="${BASH_REMATCH[2]}"
        handle_range "$start" "$end"
    elif [[ "$item" =~ ^[0-9]{1,2}$ ]]; then
        handle_single_num "$item"
    else
        echo "error: $item is not a valid number or range"
        exit 1
    fi

done
