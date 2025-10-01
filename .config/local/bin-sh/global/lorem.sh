#!/usr/bin/env bash

LOREM_FILE="$XDG_CONFIG_HOME/local/bin-sh/global/data/lorem50.txt"

function show_help() {
    cat <<EOF
Usage: lorem.sh [N<type>] | [--help]

Generate placeholder lorem ipsum text from \$LOREM_FILE.

Arguments:
  N<type>     Specify how much text to output:
              Nl   Print first N lines
              Np   Print first N paragraphs
              Nw   Print first N words
              Nc   Print first N characters

  --help, -h  Show this help text

Without arguments, the script will print the first 5 lines.

Environment:
  LOREM_FILE   Path to the lorem ipsum source file

Examples:
  lorem.sh 5l    # first 5 lines
  lorem.sh 2p    # first 2 paragraphs
  lorem.sh 25w   # first 25 words
  lorem.sh 100c  # first 100 characters
EOF
}

if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    show_help
fi

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
        show_help
        # echo "lorem.sh: unknown limiter type '$limit_type'" >&2
        exit 1 ;;
esac

