#!/usr/bin/env bash

DEFAULT_SINK=$(pactl get-default-sink)
sinks=$(pactl --format=json list sinks)

pick=$(echo "$sinks" | jq -r --arg def_sink "$DEFAULT_SINK" '
  map(
    if .name == $def_sink then
      "  " + .description
    else
      "  " + .description
    end
    ) | .[]' | rofi -dmenu -p " 󰓃 Audio source " -i -theme-str 'window { width: 1000px; height: 270px; }')
formatted_pick=$(echo "$pick" | cut -d' ' -f2- | awk '{$1=$1;print}')

if [ -n "$formatted_pick" ]; then
    sink=$(echo "$sinks" | jq --arg desc "$formatted_pick" -r '.[] | select(.description == $desc) | .name')
    pactl set-default-sink "$sink"
fi
