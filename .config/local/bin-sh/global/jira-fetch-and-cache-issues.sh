#!/usr/bin/env bash

CACHE_DIR="$XDG_CONFIG_HOME/.jira/issues/"
SYNC_TIME_FILE_PATH="$CACHE_DIR/sync"
CACHE_LIST_FILE_PATH="$CACHE_DIR/issues.json"

JQL_FILTER='project IN ("Service Desk", "New Signifikant", Signifikant, "PRODUCT(SIGP)")
AND assignee IN (currentUser())
AND status NOT IN (Done,Resolved,"TO BE VERIFIED")'

[[ -z "$JIRA_API_TOKEN" ]] && exit 1

date > "$SYNC_TIME_FILE_PATH"
jira issue ls --jql "$JQL_FILTER" --raw > "$CACHE_LIST_FILE_PATH"
