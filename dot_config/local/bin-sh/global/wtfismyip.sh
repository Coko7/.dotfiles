#!/usr/bin/env bash

if ! gum confirm "You sure you want to see it NOW???" --default=false; then
    echo "That's right. You never know who might be peeking... 👀"
    exit 1
fi

ip_data=$(curl -s https://ipv4.myip.wtf/json | jq)
ip=$(echo "$ip_data" | jq -r '.YourFuckingIPAddress')
location=$(echo "$ip_data" | jq -r '.YourFuckingLocation')
host=$(echo "$ip_data" | jq -r '.YourFuckingHostname')

RED="\e[31m"
RESET="\e[0m"

echo -e "Well, don't say I did not warn you. Here you go bud:"
echo -e "${RED}Your fucking IP:${RESET} $ip"
echo -e "${RED}Your fucking Hostname:${RESET} $host"
echo -e "${RED}Your fucking Location:${RESET} $location"
