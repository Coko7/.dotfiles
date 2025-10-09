#!/usr/bin/env bash

SWWW_ANIM="random"

function choice_prompt() {
    local prompt="  Kanumi "
    local choice
    choice=$(echo -e " Random\n󰥨 Directory\n󰥷 Image\n󰒓 Configure" | rofi -dmenu -p "$prompt" -i -theme-str 'window {width: 280px; height: 260px;}')
    echo "$choice" | cut -d' ' -f2- | tr '[:upper:]' '[:lower:]'
}

function pick_random() {
    monitor_names=$(hyprctl monitors all -j | jq '.[].name' | tr -d '"')
    for monitor in $monitor_names; do
        img=$(kanumi list | shuf | head -n 1)
        swww img -o "$monitor" "$img" -t $SWWW_ANIM
    done
}

function pick_dir() {
    local all_dirs pick monitor_names

    all_dirs=$(kanumi list | rev | cut -d'/' -f2- | rev | sort -u | cut -d'/' -f6-)
    pick=$(echo -e "$all_dirs" | rofi -dmenu -display-columns 1 -i -p " 󰥨 Directory " -theme-str 'window {width: 50%;}')
    if [[ -z "$pick" ]]; then
        exit 1
    fi

    local wp_dir="$WALLPAPERS_DIR/$pick"

    monitor_names=$(hyprctl monitors all -j | jq '.[].name' | tr -d '"')
    for monitor in $monitor_names; do
        img=$(kanumi list --directories "$wp_dir" | shuf | head -n 1)
        swww img -o "$monitor" "$img" -t $SWWW_ANIM
    done
}

function pick_image() {
    pick=$(kanumi list | cut -d'/' -f6- | rofi -dmenu -display-columns 1 -i -p " 󰥷 Image " -theme-str 'window {width: 50%;}')
    if [[ -z "$pick" ]]; then
        exit 1
    fi

    pick_full="$WALLPAPERS_DIR/$pick"

    monitor_names=$(hyprctl monitors all -j | jq '.[].name' | tr -d '"')
    for monitor in $monitor_names; do
        swww img -o "$monitor" "$pick_full" -t $SWWW_ANIM
    done
}

function edit_config() {
    xdg-open "$XDG_CONFIG_HOME/kanumi/config.toml"
}

mode=$(choice_prompt)
case "$mode" in
    random)     pick_random ;;
    directory)  pick_dir ;;
    image)      pick_image ;;
    configure)  edit_config ;;
    *) exit 1;;
esac
