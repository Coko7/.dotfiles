#!/usr/bin/env bash

bartib_actions='cancel:;cancels all currently running activities
change:;changes the current activity
check:;checks file and reports parsing errors
continue:;continues a previous activity
current:;lists all currently running activities
edit:;opens the activity log in an editor
help:;Prints this message or the help of the given subcommand(s)
last:;displays the descriptions and projects of recent activities
list:;list recent activities
projects:;list all projects
report:;reports duration of tracked activities
sanity:;checks sanity of bartib log
start:;starts a new activity
stop:;stops all currently running activities'

action=$(column --separator ';' --table <<< "$bartib_actions" | fzf  \
    --delimiter=':' --nth=1 --accept-nth=1 \
    --border-label ' Bartib Quick Actions ' --input-label ' Input ' \
    --tmux 35%,40% \
    --list-label ' Actions ')

[[ -z "$action" ]] && exit 1

case "$action" in
    start)
        project=$(echo -e "jira\nmeeting\nmisc" | fzf \
            --border-label ' Select Bartib Project ' \
            --tmux 30% \
            --list-label ' Projects ')

        case "$project" in
            jira)
                jira_issue=$(jira-my-issues.sh)
                [[ -z "$jira_issue" ]] && exit 1
                description="$jira_issue" ;;
            meeting)
                description=$(gum input --prompt="Meeting Description> " --placeholder="Daily meeting")
                [[ -z "$description" ]] && exit 1 ;;
            misc)
                description=$(gum input --prompt="task description> " --placeholder="Fix a bug with regex")
                [[ -z "$description" ]] && exit 1 ;;
            *)
                exit 1 ;;
        esac

        echo "bartib start --description \"$description\" --project \"$project\""
        ;;
    *)
        echo "bartib $action"
        ;;
esac


    # --bind 'ctrl-o:execute-silent("$BROWSER" https://signifikant.atlassian.net/browse/{2})' \
    # --bind 'ctrl-y:execute-silent(wl-copy {2..3})' \
    # --preview="jira-issue-preview.sh {2}" \
    # --preview-window=hidden
