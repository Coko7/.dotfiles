#!/usr/bin/env bash

source $SCRIPTS/bash-colors.sh

if [ "$TMUX_WS_TYPE" = "WORK" ]; then
    MACHINES_DATA=$(jq -c '.' "$XDG_CONFIG_HOME/local/bin-sh/work/ssh_machines.json")
else
    MACHINES_DATA=$(jq -c '.' "$XDG_CONFIG_HOME/local/bin-sh/personal/ssh_machines.json")
fi

echo "ssh-muxor" | figlet | lolcat -S 42

server_names=$(echo "$MACHINES_DATA" | jq -r '.[].name')
server_name=$(echo "$server_names" | gum filter)
if [ -z "$server_name" ]; then
    exit 1
fi

server_entry=$(echo "$MACHINES_DATA" | jq --arg name "$server_name" '.[] | select(.name == $name)')
server_mappings=$(echo "$server_entry" | jq '.mappings | length')
if [ "$server_mappings" -eq 0 ]; then
    echo -e "${FG_RED}No server mapping for: $server_name" >&2
    exit 1
fi

mapping_format='"\(.username)@\(.hostname):\(.port)"'
selected_mapping=""
if [ "$server_mappings" -eq 1 ]; then
    selected_mapping=$(echo "$server_entry" | jq -r ".mappings[0] | $mapping_format")
else
    selected_mapping=$(echo "$server_entry" | jq -r ".mappings[] | $mapping_format" | gum choose)
fi

mapping_hostname=$(echo "$selected_mapping" | cut -d'@' -f2 | cut -d':' -f1)
selected_mapping=$(echo "$server_entry" | jq --arg host "$mapping_hostname" '.mappings[] | select(.hostname == $host)')
if [ -z "$selected_mapping" ]; then
    exit 1
fi

hostname=$(echo "$selected_mapping" | jq -r '.hostname')
username=$(echo "$selected_mapping" | jq -r '.username')
port=$(echo "$selected_mapping" | jq '.port')

echo -e "${FG_GRAY}command: ssh -p ${FG_RED}$port ${FG_BLUE}${username}@${hostname}${COL_RESET}"
gum spin --title="Connecting..." -- nc -zv "$hostname" "$port"

ssh -p "$port" "${username}@${hostname}"
