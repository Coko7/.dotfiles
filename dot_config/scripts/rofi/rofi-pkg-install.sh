#!/usr/bin/env bash

function choice_prompt() {
    local prompt="  Install "
    local choice
    choice=$(echo -e "󰣇 Package\n󰣇 AUR" \
        | rofi -dmenu -p "$prompt" -i \
        -theme-str 'window {width: 280px; height: 200px;}')
    echo "$choice" | cut -d' ' -f2- | tr '[:upper:]' '[:lower:]'
}

mode=$(choice_prompt)
case "$mode" in
    package)    floatty.sh omarchy-pkg-install.sh ;;
    aur)        floatty.sh omarchy-pkg-aur-install.sh ;;
    *) exit 1;;
esac
