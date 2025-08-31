#!/usr/bin/env bash

FILE="$XDG_CONFIG_HOME/local/bin-sh/global/ascii-emojis.txt"
cat "$FILE" | fzf \
    --border-label ' ASCII Emojis ' --input-label ' Input ' \
    --bind 'ctrl-y:execute-silent(echo -n {} | wl-copy)+abort' \
    --color header:italic \
    --header 'Press CTRL-Y to copy command into clipboard'

