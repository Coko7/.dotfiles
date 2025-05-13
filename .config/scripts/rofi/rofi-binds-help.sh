#!/usr/bin/env bash

function get_modmask_label() {
    local modmask="$1"
    case "$modmask" in
        0) echo "" ;;
        1) echo "⇧" ;;
        8) echo "⌥" ;;
        12) echo "⌥⌃" ;;
        64) echo "⌘" ;;
        65) echo "⌘⇧" ;;
        68) echo "⌘⌃" ;;
        72) echo "⌘⌥" ;;
        73) echo "⌘⌥⇧" ;;
        *)
            echo "unsupported modmask: $modmask" >&2
            exit 1
            ;;
    esac
}

function pretty_print_bind() {
    local res modmask modmask_label key desc
    res=$(echo "$1" | jq -r '"\(.modmask)@\(.key)@\(.description)"')
    modmask=$(echo "$res" | cut -d'@' -f1)
    modmask_label=$(get_modmask_label "$modmask")
    key=$(echo "$res" | cut -d'@' -f2)
    desc=$(echo "$res" | cut -d'@' -f3)

    if [ -n "$modmask_label" ]; then
        echo -n "$modmask_label"
    fi

    echo "$key > $desc"
}

function display_binds() {
    hyprctl binds -j | jq -c '.[]' | while read -r item; do
      pretty_print_bind "$item"
    done
}

display_binds | rofi -dmenu -p "Search binds" -i -theme-str 'window {width: 1000px; height: 500px;}'
