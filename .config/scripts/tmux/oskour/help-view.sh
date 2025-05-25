#!/usr/bin/env bash

source $SCRIPTS/bash-colors.sh

fzf_preview_script="$SCRIPTS/tmux/oskour/help-view-preview.sh"

pick=$(echo "$PATH" \
    | tr : '\n' \
    | xargs -I {} find {} -type f -executable -printf "%P\n" \
    | sort -u \
    | fzf --exact \
    --border-label ' Oskour-Help: Interactive Help Fuzzer ' --input-label ' Input ' \
    --list-label ' Program List ' --preview-label ' Preview ' \
    --preview "$fzf_preview_script {}")

if [ -z "$pick" ]; then
    exit 0
fi

if "$pick" --help 2>&1; then
    tmux neww bash -c "$pick --help 2>&1 | bat --color=always --paging=always --style=numbers --language=help | less -R"
else
    echo -e "${FG_RED}ERROR: ${COL_RESET}Incompatible command '$pick' \n(╯°□°)╯︵ ┻━┻" | less -R
fi
