#!/usr/bin/env bash

SWWW_ANIM="random"

function choice_prompt() {
    local prompt="  Kanumi "
    local choice
    choice=$(echo -e " Random\n󰥨 Directory\n󰥷 Image\n Identify\n󰒓 Configure" \
        | rofi -dmenu -p "$prompt" -i \
        -theme-str 'window {width: 280px; height: 300px;}')
    echo "$choice" | cut -d' ' -f2- | tr '[:upper:]' '[:lower:]'
}

function pick_random() {
    monitor_names=$(hyprctl monitors all -j | jq '.[].name' | tr -d '"')
    for monitor in $monitor_names; do
        img=$(kanumi list | shuf | head -n 1)
        swww img -o "$monitor" "$img" -t $SWWW_ANIM
    done
}

mode=$(choice_prompt)
case "$mode" in
    random)     pick_random ;;
    directory)  floatty.sh fzf-swww-kanumi-dir.sh ;;
    image)      floatty.sh fzf-swww-kanumi-img.sh ;;
    identify)   floatty.sh fzf-swww-kanumi-identify.sh ;;
    configure)  floatty.sh "$EDITOR $XDG_CONFIG_HOME/kanumi/config.toml" ;;
    *) exit 1;;
esac
