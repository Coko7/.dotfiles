#!/usr/bin/env bash

VPN_STATE_FILE=$XDG_CONFIG_HOME/local/bin-sh/global/data/vpn_state.txt

active_vpn=$(nmcli con show --active \
    | jc --nmcli \
    | jq -r '.[] | select(.type == "wireguard") | .name')

# if no vpn active
[[ -z "$active_vpn" ]] && rm "$VPN_STATE_FILE" && pkill -RTMIN+8 waybar

# if vpn active
[[ ! -z "$active_vpn" ]] && echo "$active_vpn" >  "$VPN_STATE_FILE" && pkill -RTMIN+8 waybar
