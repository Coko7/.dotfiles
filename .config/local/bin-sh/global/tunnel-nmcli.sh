#!/usr/bin/env bash

GRAY="\e[37m"
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
RESET="\e[0m"

VPN_STATE_FILE=$XDG_CONFIG_HOME/local/bin-sh/global/data/vpn_state.txt

function pretty() {
    local color="$1"
    local message=$2
    echo -e "${color}$message${RESET}"
}

echo "TunNel" | figlet | lolcat -S 23

active_wg_con=$(nmcli --terse --fields NAME,UUID,TYPE connection show --active | grep wireguard)
if [ -n "$active_wg_con" ]; then
    wg_con_name=$(echo "$active_wg_con" | cut -d ':' -f1)
    # connected
    pretty "$GREEN" "󰳌 Active connection: $wg_con_name"
    if ! gum confirm "Disconnect from $wg_con_name?" --default=false; then
        exit 0
    fi

    if ! (gum spin --title "Disconnecting from $wg_con_name..." -- sleep 0.5 \
        && nmcli connection down "$wg_con_name" > /dev/null 2>&1); then
        pretty "$RED" "Failed to disconnect from: $wg_con_name"
        exit 1
    fi

    rm "$VPN_STATE_FILE"
    pretty "$BLUE" "󰦜 Successfully disconnected from $wg_con_name"
    notify-send -u normal "VPN" "Disconnected" \
        -i "$HOME/Pictures/System/unlocked.png" -t 3000 \
        -h string:x-canonical-private-synchronous:vpn-notif --transient

    pkill -RTMIN+8 waybar
else
    # not connected
    pretty "$GRAY" "󰦜 Active connection: None"
    if ! gum confirm "Connect to an interface?"; then
        exit 1
    fi

    interface=$(nmcli --terse --fields NAME,UUID,TYPE connection show | grep wireguard \
        | cut -d':' -f1 \
        | gum choose --header "Select interface")
    if [ -z "$interface" ]; then
        exit 1
    fi

    if ! (gum spin --title "Connecting to $interface..." -- sleep 0.5 \
        && nmcli connection up "$interface" > /dev/null 2>&1); then
        pretty "$RED" "Failed to connect to: $interface"
        exit 1
    fi

    echo "$interface" > "$VPN_STATE_FILE"
    pretty "$GREEN" "󰳌 Successfully connected to $interface"
    notify-send -u normal "VPN" "Connected to: $interface" \
        -i "$HOME/Pictures/System/locked.png" -t 3000 \
        -h string:x-canonical-private-synchronous:vpn-notif --transient

    pkill -RTMIN+8 waybar
fi
