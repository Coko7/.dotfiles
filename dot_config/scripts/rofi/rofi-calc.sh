#!/usr/bin/env bash

LC_MONETARY=de_DE.UTF-8 rofi \
    -show calc \
    -modi calc \
    -display-calc " 󰃬 Calculator " \
    -no-show-match \
    -no-sort \
    -theme-str 'window {width: 50%; height: 40%;}' \
    -calc-command "echo -n '{result}' | wl-copy"
