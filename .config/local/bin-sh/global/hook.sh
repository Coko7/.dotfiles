#!/usr/bin/env bash

DIRECTORY=$1

[[ -z $DIRECTORY ]] && DIRECTORY="$HOME/Downloads"
[[ ! -d $DIRECTORY ]] && echo "error: not a directory '$DIRECTORY'" && exit 1

pick=$(find "$DIRECTORY" -type f -printf '%T@ %p\n' \
    | sort -nr \
    | cut -d' ' -f2- \
    | fzf --delimiter '/' --with-nth 5.. \
    --preview="bat --color=always --style=plain {}")

[[ -z $pick ]] && exit 0
[[ ! -f $pick ]] && echo "error: no such file '$pick'" && exit 1

mv "$pick" . && echo "🪝 moved '$pick' to '$(pwd)'"
