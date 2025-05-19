#!/usr/bin/env bash

LOREM_FILE="$XDG_CONFIG_HOME/local/bin-sh/global/data/lorem50.txt"

if [ -z "$1" ]; then
    head -n 5 "$LOREM_FILE"
    exit 0
fi

limit="$1"

# substr from 0..(limit.len() - 1) -> everything EXCEPT last char
limit_count="${limit:0:${#limit}-1}"

# substr from (limit.len() -1).. -> last char
limit_type="${limit: -1}"

case "$limit_type" in
    # print first N lines/paragraphs
    l|p) head -n "$limit_count" "$LOREM_FILE" ;;
    # print first N words
    w) 
        tr -s '[:space:]' '\n' < "$LOREM_FILE" \
            | head -n "$limit_count" \
            | paste -sd' ' - ;;
    # print first N chars
    c) head -c "$limit_count" "$LOREM_FILE" ;;
    *)
        echo "lorem.sh: unknown limiter type '$limit_type'" >&2
        exit 1 ;;
esac
