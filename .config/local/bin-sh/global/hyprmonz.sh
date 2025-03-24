#!/usr/bin/env bash

HYPR_DIR="$XDG_CONFIG_HOME/hypr"
SETUPS_DIR="$HYPR_DIR/monitor_setups"
MON_SYM_LNK="$HYPR_DIR/monitors.conf"

pick=$(find "$SETUPS_DIR" -type f -printf "%f\n" \
    | fzf -i --prompt="Monitor setup> " \
    --preview="bat $SETUPS_DIR/{}")

if [ -z "$pick" ]; then
    exit 1
fi

if gum confirm "Are you sure you want to switch to $pick?" --default=false; then
    target_mon_file="$SETUPS_DIR/$pick"
    ln -vsf "$target_mon_file" "$MON_SYM_LNK"

    if [ -n "${HYPRLAND_INSTANCE_SIGNATURE}" ]; then
        hyprctl reload
    fi
fi
