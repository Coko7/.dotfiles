#!/usr/bin/env bash

function get_modmask_label() {
    local K_SUPER=""
    local K_CTRL="󰘴"
    local K_ALT="󰘵"
    local K_SHIFT="󰘶"
    local modmask="$1"
    case "$modmask" in
        0)  echo "" ;;
        1)  echo "$K_SHIFT" ;;
        8)  echo "$K_ALT" ;;
        12) echo "${K_ALT}${K_CTRL}" ;;
        64) echo "$K_SUPER" ;;
        65) echo "${K_SUPER} ${K_SHIFT}" ;;
        68) echo "${K_SUPER} ${K_CTRL}" ;;
        72) echo "${K_SUPER} ${K_ALT}" ;;
        73) echo "${K_SUPER} ${K_ALT}${K_SHIFT}" ;;
        *)
            echo "unsupported modmask: $modmask" >&2
            exit 1 ;;
    esac
}

function get_key_label() {
    case "$1" in
        "space")                    echo "󱁐" ;;
        "return")                   echo "󰌑" ;;
        "comma")                    echo "," ;;
        "period")                   echo "." ;;
        "PRINT")                    echo "Prt" ;;
        "mouse_down")               echo "󱕐" ;;
        "mouse_up")                 echo "󱕑" ;;
        "mouse:272")                echo "󰍽 (L)" ;;
        "mouse:273")                echo "󰍽 (R)" ;;
        "XF86AudioLowerVolume")     echo "󰝞" ;;
        "XF86AudioMicMute")         echo "󰍭" ;;
        "XF86AudioMute")            echo "󰝟" ;;
        "XF86AudioNext")            echo "󰒭" ;;
        "XF86AudioPause")           echo "󰏤" ;;
        "XF86AudioPlay")            echo "󰐊" ;;
        "XF86AudioPrev")            echo "󰒮" ;;
        "XF86AudioRaiseVolume")     echo "󰝝" ;;
        "XF86MonBrightnessDown")    echo "󱩎" ;;
        "XF86MonBrightnessUp")      echo "󱩕" ;;
        *)                          echo "$1" | tr '[:upper:]' '[:lower:]' ;;
    esac
}

function pretty_print_bind() {
    local res modmask modmask_label key key_label desc
    res=$(echo "$1" | jq -r '"\(.modmask)@\(.key)@\(.description)"')
    modmask=$(echo "$res" | cut -d'@' -f1)
    modmask_label=$(get_modmask_label "$modmask")
    key=$(echo "$res" | cut -d'@' -f2)
    key_label=$(get_key_label "$key")

    desc=$(echo "$res" | cut -d'@' -f3)

    local prefix="[ "
    if [ -n "$modmask_label" ]; then
        prefix="[ $modmask_label "
    fi

    echo "${prefix}$key_label ] $desc"
}

function display_binds() {
    hyprctl binds -j | jq -c '.[]' | while read -r item; do
      pretty_print_bind "$item"
    done
}

display_binds | rofi -dmenu -p " 󱎸 Search bindings " -i -theme-str 'window {width: 1000px; height: 500px;}'
