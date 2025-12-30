#!/usr/bin/env bash

SWWW_ANIM="random"

pick=$(kanumi list \
    | fzf-rofi.sh --prompt='Image> ' --preview="fzf-preview.sh {}" \
    --delimiter='/' --with-nth=6..)
[[ -z "$pick" ]] && exit 1

monitor_names=$(hyprctl monitors all -j | jq '.[].name' | tr -d '"')
for monitor in $monitor_names; do
    swww img -o "$monitor" "$pick" -t $SWWW_ANIM
done
