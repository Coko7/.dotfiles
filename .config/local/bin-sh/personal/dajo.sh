#!/usr/bin/env bash

CLI_NAME="dajo"
JOURNAL_DIR="$PROJ_PERSO/Notes/journal"

function show_help() {
    cat <<EOF
Usage: $CLI_NAME [OPTION]
Manage your daily journal.

Options:
  -c, --create DATE     Crate a journal entry for the given DATE
  -g, --get DATE        Get the entry path that matches the given DATE
  -l, --lookup PATH     Lookup the date of a given entry PATH
  -o, --open DATE       Open the journal entry for DATE
  -h, --help            Show this help message

Examples:
  $CLI_NAME --create yesterday
  $CLI_NAME --get today
  $CLI_NAME --open "last monday"
EOF
}

function get_entry_path() {
    local date_exp="$1"
    local date

    if [ -n "$date_exp" ]; then
        if ! date=$(date -d "$1"); then
            echo "daily-journal: failed to imply date from '$1'"
            exit 1
        fi
    else
        date=$(date)
    fi

    year=$(date -d "$date" +%Y)
    month_dir=$(date -d "$date" +%m-%b)
    day=$(date -d "$date" +%d)
    date=$(date -d "$date" +%Y-%m-%d)

    echo "$JOURNAL_DIR/$year/$month_dir/$day.md"
}

function create_journal_entry() {
    local date_exp="$1"
    local entry_path
    entry_path=$(get_entry_path "$date_exp")

    local date
    date=$(date -d "$date_exp" +%Y-%m-%d)

    if [ -f "$entry_path" ]; then
        echo "exist:$entry_path"
        return 0
    fi

    mkdir -p "$(dirname "$entry_path")"
    title=$(date -d "$date_exp" +"%A %-d, %B %Y")
    todo_path="$JOURNAL_DIR/todo.md"
    default_content=$(sed "s/__TITLE__/$title/" "$JOURNAL_DIR/template.md"  \
        | sed "s/__DATE__/$date/" \
        | sed "/__TODO-CONTENT__/{
            r $todo_path
            d
        }")
    echo "$default_content" > "$entry_path"

    echo "created:$entry_path"
}

function lookup_journal_entry() {
    local entry_path="$1"
    if [ ! -f "$entry_path" ]; then
        echo "$CLI_NAME: no such file '$entry_path'"
        return 1
    fi

    local date
    if ! date=$(yq --exit-status --front-matter=extract '.date' "$entry_path"); then
        echo "$CLI_NAME: failed to extract .date for '$entry_path'"
        return 1
    fi

    echo "$date"
}

function open_daily_journal() {
    local date_exp="$1"
    local entry_path
    entry_path=$(get_entry_path "$date_exp")

    if [ ! -f "$entry_path" ]; then
        create_journal_entry "$date_exp"
    fi

    $EDITOR "$entry_path"
}

ACTION="$1"
DATE_EXPR="$2"

case "$ACTION" in
    --get|-g) get_entry_path "$DATE_EXPR" ;;
    --create|-c) create_journal_entry "$DATE_EXPR" ;;
    --lookup|-l) lookup_journal_entry "$DATE_EXPR" ;;
    --open|-o) open_daily_journal "$DATE_EXPR" ;;
    *) show_help ;;
esac
