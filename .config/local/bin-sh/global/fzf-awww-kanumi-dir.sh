#!/usr/bin/env bash

AWWW_ANIM="random"

pick=$(kanumi dirs |
  fzf-rofi.sh --prompt='Directory> ' \
    --preview-window 'right:60%:wrap' --preview='fzf-img-dir-preview.sh {}' \
    --delimiter='/' --with-nth=6..)
[[ -z "$pick" ]] && exit 1

monitor_names=$(hyprctl monitors all -j | jq --raw-output '.[].name')
for monitor in $monitor_names; do
  img=$(kanumi list --directories "$pick" | shuf --head-count=1)
  awww img --outputs "$monitor" "$img" --transition-type $AWWW_ANIM
done
