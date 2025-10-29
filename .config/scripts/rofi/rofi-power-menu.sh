#!/usr/bin/env bash

function confirm_prompt() {
    prompt=$1
    choice=$(echo -e " Yes\n No" \
        | rofi -dmenu -p "$prompt" \
        -i -theme-str 'window {width: 250px; height: 150px;}')

    if [ "$choice" != " Yes" ]; then
        return 1
    fi

    return 0
}

# options="󰐥 Power off\n󰜉 Reboot\n󰒲 Suspend\n󰍃 Logout\n󰌾 Lock\n󰸉 Wallpaper"
options=" Install\n󰐥 Power off\n󰜉 Reboot\n󰒲 Suspend\n󰌾 Lock\n Kanumi\n󰃬 Calculator\n󰛨 Backlight\n󰞋 Keybinds"
# pick=$(echo -e $options | rofi -dmenu -p "󰒓 Action" -i -theme-str 'window {width: 15%; height: 30%;}')
# pick=$(echo -e $options | rofi -dmenu -p "󰒓 Action" -i -theme-str 'window {width: 10%; height: 22%;}')
pick=$(echo -e "$options" | rofi -dmenu -p "   Action " -i -theme-str 'window {width: 450px; height: 300px;}')
formatted_pick=$(echo "$pick" | cut -d' ' -f2-)

case $formatted_pick in
    "Power off") confirm_prompt "󰋣 Bed time? " && systemctl poweroff ;;
    "Reboot") confirm_prompt "󰜉 Reboot? " && systemctl reboot ;;
    "Suspend") systemctl suspend ;;
    # "Logout") confirm_prompt "U sure about logging out?" && loginctl terminate-session ;;
    "Lock") loginctl lock-session ;;
    "Kanumi") bash "$SCRIPTS/rofi/rofi-kanumi.sh" ;;
    "Calculator") bash "$SCRIPTS/rofi/rofi-calc.sh" ;;
    "Backlight") bash "$SCRIPTS/rofi/rofi-man-backlight.sh" ;;
    "Keybinds") bash "$SCRIPTS/rofi/rofi-binds-help.sh" ;;
    "Install") bash "$SCRIPTS/rofi/rofi-pkg-install.sh" ;;
esac
