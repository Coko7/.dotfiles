#!/usr/bin/env bash

color=`hyprpicker -a`
if [ -n "$color" ]; then
    TMP_PATH=`mktemp -t pikolorXXXXX.png`
    magick -size 10x10 "xc:$color" $TMP_PATH
    notify-send -u low "Hyprpicker" \
        "Copied $color to clipboard" \
        -i $TMP_PATH -t 2000 \
        -h string:x-canonical-private-synchronous:pick-color --transient

    rm $TMP_PATH
fi
