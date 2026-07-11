#!/usr/bin/env bash

options="10%\n20%\n30%\n40%\n50%\n60%\n70%\n80%\n90%\n100%"
pick=$(echo -e "$options" | rofi -dmenu -p " 󰛨 Backlight " -i -theme-str 'window { width: 250px; height: 300px; }')

if [ -n "$pick" ]; then
    light=${pick::-1}
    lumen.sh "$light"
fi
