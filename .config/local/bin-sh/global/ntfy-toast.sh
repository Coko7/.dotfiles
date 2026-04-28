#!/usr/bin/env bash

DEFAULT_ICON="$HOME/Pictures/System/navi.png"

title="$1"
body="$2"
img_path="${3:-$DEFAULT_ICON}"
hint="${4:-'misc-ntfy'}"
sound_file="${5-/usr/share/sounds/freedesktop/stereo/bell.oga}"

if [ -z "$body" ]; then
  body="$1"
  title="Hey listen!"
fi

if [ ! -f "$img_path" ]; then
  img_path=$(fd "$img_path" "$HOME/Pictures/System")
  if [ ! -f "$img_path" ]; then
    img_path="$DEFAULT_ICON"
  fi
fi

notify-send --urgency=low "$title" "$body" \
  --icon="$img_path" --expire-time=2000 \
  --hint="string:x-canonical-private-synchronous:$hint" \
  --transient
paplay "$sound_file"
