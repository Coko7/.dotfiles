#!/usr/bin/env bash

AWWW_ANIM="random"

pick=$(kanumi list \
    | fzf-rofi.sh --prompt='Image> ' --preview="fzf-preview.sh {}" \
    --delimiter='/' --with-nth=6..)
[[ -z "$pick" ]] && exit 1

monitor_names=$(hyprctl monitors all -j | jq '.[].name' | tr -d '"')
for monitor in $monitor_names; do
    awww img -o "$monitor" "$pick" -t $AWWW_ANIM
done
