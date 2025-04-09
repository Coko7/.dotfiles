#!/usr/bin/env bash

fzf_preview_script="$SCRIPTS/tmux/oskour/help-view-preview.sh"

pick=$(echo "$PATH" \
    | tr : '\n' \
    | xargs -I {} find {} -type f -executable -printf "%P\n" \
    | sort -u \
    | fzf --exact --prompt="Search Help> " --preview "$fzf_preview_script {}")

if [ -z "$pick" ]; then
    exit 0
fi

tmux neww bash -c "$pick --help 2>&1 | bat --color=always --plain --language=help | less -R"
