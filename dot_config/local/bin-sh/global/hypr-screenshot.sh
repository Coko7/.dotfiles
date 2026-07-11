#!/usr/bin/env bash
# Script stolen from basecamp/omarchy because they know how to cook.

OUTPUT_DIR="$HOME/Pictures/Screenshots"

if [[ ! -d "$OUTPUT_DIR" ]]; then
  notify-send "Screenshot directory does not exist: $OUTPUT_DIR" -u critical -t 3000
  exit 1
fi

pkill slurp || hyprshot -m "${1:-region}" --raw |
  satty --filename - \
    --output-filename "$OUTPUT_DIR/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png" \
    --early-exit \
    --actions-on-enter save-to-clipboard \
    --save-after-copy \
    --copy-command 'wl-copy'
