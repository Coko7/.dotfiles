#!/usr/bin/env bash

root_path=$(kanumi config show --json | jq -r '.root_path')
metadata_path=$(kanumi config show --json | jq -r '.meta_path')

pick=$(swww query \
    | sed 's/^: //g' \
    | sed 's/currently displaying: //g' \
    | sed "s|$root_path||" \
    | fzf-rofi.sh --prompt='Search active> ' \
    --preview-window 'down:75%:wrap' \
    --preview="echo {} | cut -d: -f4 | awk '{print \$1}' | xargs -I{} fzf-preview.sh $root_path{}")
[[ -z "$pick" ]] && exit 1

formatted_pick=$(echo -e "$pick" | rev | cut -d: -f1 | rev \
    | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
line_number=$(rg --no-heading --line-number "$formatted_pick" "$metadata_path" | cut -d: -f1)
nvim "+$line_number" "$metadata_path"
