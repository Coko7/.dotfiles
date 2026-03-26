#!/usr/bin/env bash

title="$1"
body="$2"
img_path="$3"
hint="$4"

if [ -z "$body" ]; then
    body="$1"
    title="Hey listen!"
fi

if [ -z "$img_path" ] || [ ! -f "$img_path" ]; then
    img_path="$HOME/Pictures/System/navi.png"
fi

notify-send --urgency=low "$title" "$body" \
    --icon="$img_path" --expire-time=2000 \
    --hint="string:x-canonical-private-synchronous:misc-ntfy" \
    --transient
