#!/usr/bin/env bash

CACHE_DIR="$XDG_CONFIG_HOME/.jira/issues/"
CACHE_LIST="$CACHE_DIR/issues.tmp"
JQL_FILTER='project IN ("Foo Bar", Baz) AND assignee IN (currentUser()) AND status NOT IN (Done,Resolved)'

[[ -z "$JIRA_API_TOKEN" ]] && { jira issue; exit 1; }

if [ -f "$CACHE_LIST" ]; then
    date_str=$(head -n 1 "$CACHE_LIST")
    date_sec=$(date -d "$date_str" +%s)
    now_sec=$(date +%s)

    diff_sec=$((now_sec - date_sec))
    twelve_hours_sec=$((12 * 60 * 60))
fi

if [[ ! -f "$CACHE_LIST" || "$diff_sec" -ge "$twelve_hours_sec" ]]; then
    date > "$CACHE_LIST"
    # jira issue ls -q "$JQL_FILTER" --plain --no-headers >> "$CACHE_LIST"
    jira issue ls -q "$JQL_FILTER" --plain --no-headers | sed 's/\t\+/\t/g' >> "$CACHE_LIST"
fi

all_issues=$(tail -n +2 "$CACHE_LIST")
echo -e "$all_issues" | fzf \
    --delimiter='\t' --with-nth=2,3 --accept-nth=2,3 \
    --border-label ' Fuzzy Find JIRA issues ' --input-label ' Input ' \
    --header 'CTRL-O to open in Web browser / CTRL-Y to yank to clipboard' \
    --bind 'ctrl-o:execute-silent("$BROWSER" https://foobar.atlassian.net/browse/{2})' \
    --bind 'ctrl-y:execute-silent(wl-copy {2..3})' \
    --list-label ' Issues ' --preview-label ' Issue Preview ' \
    --preview="jira-issue-preview.sh {2}" \
    --preview-window=hidden
