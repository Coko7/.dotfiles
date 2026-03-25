#!/usr/bin/env bash

CACHE_DIR="$XDG_CONFIG_HOME/.jira/issues/"
SYNC_TIME_FILE="$CACHE_DIR/sync"
ISSUES_FILE="$CACHE_DIR/issues.json"

[[ -z "$JIRA_API_TOKEN" ]] && exit 1

if [ -f "$ISSUES_FILE" ]; then
    date_str=$(head -n 1 "$SYNC_TIME_FILE")
    date_sec=$(date -d "$date_str" +%s)
    now_sec=$(date +%s)

    diff_sec=$((now_sec - date_sec))
    twelve_hours_sec=$((12 * 60 * 60))
fi

if [[ ! -f "$ISSUES_FILE" || "$diff_sec" -ge "$twelve_hours_sec" ]]; then
    gum spin --title="fetching JIRA issues" -- \
        bash jira-fetch-and-cache-issues.sh
fi

formatted_issues=$(jq --raw-output '.[] | "\(.key)|\(.fields.summary)"' < "$ISSUES_FILE")
table=$(column --separator '|' --table <<< "$formatted_issues")

fzf \
    --delimiter='  +' --with-nth='1,2' --accept-nth=1 \
    --border-label ' Fuzzy Find JIRA issues ' --input-label ' Input ' \
    --list-label ' Issues ' --preview-label ' Previewing issue ' \
    --header 'CTRL-O to open in Web browser / CTRL-Y to yank to clipboard / CTRL-C to clear cache' \
    --bind 'ctrl-o:execute-silent("$BROWSER" https://signifikant.atlassian.net/browse/{1})' \
    --bind 'ctrl-c:execute-silent(command rm ~/.config/.jira/issues/issues.json)' \
    --bind 'ctrl-y:execute-silent(wl-copy {1},{2})' \
    --bind 'focus:transform-preview-label:printf "Previewing %s" {1}' \
    --preview="jira-issue-preview.sh {1}" \
    --preview-window=hidden <<< "$table"
