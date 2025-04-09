#!/usr/bin/env bash

executable_name=$1

if help_text=$("$executable_name" --help 2>&1); then
    echo -e "$help_text" \
        | bat --color=always --plain --language=help \
        | less -R
else
    echo "Incompatible command"
    exit 0
fi
