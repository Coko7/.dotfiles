#!/usr/bin/env bash

options="20%\n40%\n50%\n60%\n80%\n100%"
pick=$(echo -e "$options" | rofi -dmenu -p " 󰛨 Backlight " -i -theme-str 'window { width: 250px; height: 220px; }')

if [ -n "$pick" ]; then
    light=${pick::-1}
    lumen.sh "$light"
fi
