#!/usr/bin/env bash

LOREM_FILE="$XDG_CONFIG_HOME/local/bin-sh/global/data/lorem50.txt"

paragraphs=10
if [ -n "$1" ]; then
    paragraphs=$(($1 * 2))
fi

head -n "$paragraphs" "$LOREM_FILE"
