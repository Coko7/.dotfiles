#!/usr/bin/env bash

wm_class_suffix="$1"
shift

full_wm_class="floater-neovide-$wm_class_suffix"

# prevent multiple floater-neovide-<FOO> windows to be opened at the same time
hyprctl clients -j |
  jq --exit-status --arg wm_class "$full_wm_class" 'any(.[]; .class == $wm_class)' >/dev/null 2>&1 &&
  exit 1

neovide --wayland_app_id "$full_wm_class" "$@"
