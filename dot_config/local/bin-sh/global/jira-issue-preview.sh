#!/usr/bin/env bash

CACHE_DIR="$XDG_CONFIG_HOME/.jira/issues/"
[[ -z "$JIRA_API_TOKEN" ]] && { jira issue; exit 1; }

issue_id="$1"
[[ -z "$issue_id" ]] && echo "expects issue ID to be passed" && exit 1

issue_cache="$CACHE_DIR/iss_$issue_id.tmp"

if [ ! -s "$issue_cache" ]; then
    jira issue show "$issue_id" > "$issue_cache"
fi

bat "$issue_cache"
