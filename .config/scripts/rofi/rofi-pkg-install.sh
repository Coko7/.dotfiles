#!/usr/bin/env bash

TERMINAL="ghostty --gtk-single-instance=true"

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
    package)    $TERMINAL -e omarchy-pkg-install.sh ;;
    aur)        $TERMINAL -e omarchy-pkg-aur-install.sh ;;
    *) exit 1;;
esac
