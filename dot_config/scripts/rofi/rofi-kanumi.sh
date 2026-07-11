#!/usr/bin/env bash

SWWW_ANIM="random"

function choice_prompt() {
  local prompt="  Kanumi "
  local choice
  choice=$(echo -e " Random\n󰥨 Directory\n󰥷 Image\n Identify\n󰒓 Configure" |
    rofi -dmenu -p "$prompt" -i \
      -theme-str 'window {width: 280px; height: 300px;}')
  echo "$choice" | cut --delimiter=' ' --fields='2-' | tr '[:upper:]' '[:lower:]'
}

function pick_random() {
  monitor_names=$(hyprctl monitors all -j | jq --raw-output '.[].name')
  for monitor in $monitor_names; do
    img=$(kanumi list | shuf --head-count=1)
    awww img --outputs "$monitor" "$img" --transition-type $SWWW_ANIM
  done
}

mode=$(choice_prompt)
case "$mode" in
random)
  pick_random
  ;;
directory)
  floatty.sh fzf-awww-kanumi-dir.sh
  ;;
image)
  floatty.sh fzf-awww-kanumi-img.sh
  ;;
identify)
  floatty.sh fzf-awww-kanumi-identify.sh
  ;;
configure)
  floatty.sh "$EDITOR $XDG_CONFIG_HOME/kanumi/config.toml"
  ;;
*)
  exit 1
  ;;
esac
