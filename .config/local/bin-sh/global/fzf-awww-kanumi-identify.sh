#!/usr/bin/env bash

metadata_path=$(kanumi config show --json | jq --raw-output '.meta_path')

pick=$(
  awww query --json |
    jq --raw-output '."".[] | "\(.name): \(.displaying.image)"' |
    fzf-rofi.sh --prompt='Search active> ' \
      --delimiter=' ' \
      --accept-nth=2 \
      --header='CTRL-O to view image / CTRL-Y to yank path to clipboard' \
      --preview-window 'down:70%:wrap' \
      --preview="fzf-preview.sh {2}" \
      --bind 'ctrl-o:execute-silent:imv -f {2}' \
      --bind 'ctrl-y:execute-silent:wl-copy {2} && ntfy-toast.sh "kanumi" "Copied wallpaper path to cliboard" "/home/coco/Pictures/System/art.png"'
)
[[ -z "$pick" ]] && exit 1

line_number=$(rg --no-heading --line-number "$pick" "$metadata_path" |
  cut --delimiter=':' --fields=1)

nvim "+$line_number" "$metadata_path"
