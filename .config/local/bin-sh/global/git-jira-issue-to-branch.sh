#!/usr/bin/env bash

CACHE_DIR="$XDG_CONFIG_HOME/.jira/issues/"
ISSUES_FILE="$CACHE_DIR/issues.json"

issue_num=$(fzf-jira-issues.sh)

[[ -z "$issue_num" ]] && exit 1

issue_title=$(jq --raw-output --arg key "$issue_num" '.[] 
    | select(.key == $key) 
    | .fields.summary' < "$ISSUES_FILE")

issue_name_kebab=$(echo "$issue_title" \
    | tr '[:upper:]' '[:lower:]' \
    | tr '+ ' '--' \
    | tr --delete "':()")

echo "$(whoami)/$issue_num/$issue_name_kebab"
