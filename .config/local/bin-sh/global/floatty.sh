#!/usr/bin/env bash

# prevent multiple floater-kitty windows to be opened at the same time
hyprctl clients -j \
    | jq --exit-status 'any(.[]; .class == "floater-kitty")' >/dev/null 2>&1 \
    && exit 1

kitty --class floater-kitty sh -c "$@"
