#!/usr/bin/env bash

active_layout=$(hyprkeyb.sh get-active-layout)
all_layouts=$(hyprkeyb.sh get-all-layouts)

pick=$(echo "$all_layouts" | jq -r --arg layout "$active_layout" '
  map(
    if .name == $layout then
      "  " + .name
    else
      "  " + .name
    end
    ) | .[]' | rofi -dmenu -p "   Layout " -i -theme-str 'window { width: 350px; height: 250px; }')
formatted_pick=$(echo "$pick" | cut -d' ' -f3-)

if [ -n "$formatted_pick" ]; then
    hyprkeyb.sh set-layout "$formatted_pick"
fi
