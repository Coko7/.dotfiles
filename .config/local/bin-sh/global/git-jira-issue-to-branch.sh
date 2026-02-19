#!/usr/bin/env bash

CACHE_DIR="$XDG_CONFIG_HOME/.jira/issues/"

issue_raw=$(jira-my-issues.sh)
[[ -z "$issue_raw" ]] && exit 1

issue=$(echo "$issue_raw" | cut -d $'\t' -f1)
issue_cache="$CACHE_DIR/iss_$issue.tmp"
issue_name=$(grep "#" < "$issue_cache" | cut -d'#' -f2 | awk '{$1=$1};1')
issue_name_kebab=$(echo "$issue_name" \
    | tr -d "'" \
    | tr ' ' '-' \
    | tr -d ':' \
    | tr -d '(' \
    | tr -d ')')

echo "$(whoami)/$issue/$issue_name_kebab"
