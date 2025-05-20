#!/usr/bin/env bash

# ================================ WARNING ==================================== #
#                                                                               #
# This script only works with Hyprland compositor / Window manager for Wayland. #
#                                                                               #
# ================================ WARNING ==================================== #

function main() {
    monitor_names=$(hyprctl monitors all -j | jq '.[].name' | tr -d '"')

    for monitor in $monitor_names; do
        img=$(kanumi list | shuf | head -n 1)
        swww img -o "$monitor" "$img" -t outer
    done
}

main "$@"; exit
