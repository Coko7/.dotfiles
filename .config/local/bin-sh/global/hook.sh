#!/usr/bin/env bash

DIRECTORY=$1

[[ -z $DIRECTORY ]] && DIRECTORY="$HOME/Downloads"
[[ ! -d $DIRECTORY ]] && echo "error: not a directory '$DIRECTORY'" && exit 1

selected_files=$(find "$DIRECTORY" -type f -printf '%T@ %p\n' \
    | sort -nr \
    | cut -d' ' -f2- \
    | fzf --delimiter '/' --with-nth 5.. --multi \
    --preview="bat --color=always --style=plain {}")

[[ -z $selected_files ]] && exit 0

for file in ${selected_files}; do
    [[ ! -f $file ]] && echo "error: no such file '$file'" && exit 1
    mv "$file" . && echo "🪝 moved '$file' to '$(pwd)'"
done
