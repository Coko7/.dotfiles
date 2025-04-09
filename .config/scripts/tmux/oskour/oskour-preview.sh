#!/usr/bin/env bash

option_text="$1"

option_name=$(echo "$option_text" | cut -d':' -f1)
option_desc=$(echo "$option_text" | cut -d':' -f2-)

echo "$option_name" | figlet | lolcat -f -S 42

echo -e "==============================\n" | lolcat -f -S 42

echo -e "$option_desc"
