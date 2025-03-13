#!/usr/bin/env bash

pick=$(find $(echo "$PATH" | tr : '\n') -type f -executable -printf "%P\n" \
    | sort -u \
    | fzf --exact --prompt="Search Help> ")
    # | fzf --exact --prompt="Search Help> " --preview="{} --help 2>&1 | bat --color=always --plain --language=help")
if [ -z "$pick" ]; then
    exit 0
fi


tmux neww bash -c "$pick --help 2>&1 | bat --color=always --plain --language=help | less -R"
