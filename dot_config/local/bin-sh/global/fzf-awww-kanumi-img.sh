#!/usr/bin/env bash

AWWW_ANIM="random"

pick=$(kanumi list |
  fzf-rofi.sh --prompt='Image> ' --preview="fzf-preview.sh {}" \
    --delimiter='/' --with-nth=6..)
[[ -z "$pick" ]] && exit 1

monitor_names=$(hyprctl monitors all -j | jq --raw-output '.[].name')
for monitor in $monitor_names; do
  awww img --outputs "$monitor" "$pick" --transition-type $AWWW_ANIM
done
