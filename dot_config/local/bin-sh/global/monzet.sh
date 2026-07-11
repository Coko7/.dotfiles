#!/usr/bin/env bash

HYPR_DIR="$XDG_CONFIG_HOME/hypr"
SETUPS_DIR="$HYPR_DIR/monitor_setups"
MON_SYM_LNK="$HYPR_DIR/monitors.conf"

function find_main_monitor() {
    monitors=$(hyprctl monitors -j)
    json_query='first(.[].name)'
    if [ "$(echo "$monitors" | jq 'length')" -gt 1 ]; then
        json_query='map(select(.name | startswith("eDP") | not)) | first(.[].name)'
    fi
    echo "$monitors" | jq -r "$json_query"
}

pick=$(find "$SETUPS_DIR" -type f -printf "%f\n" | fzf-rofi.sh \
    --border-label ' Interactive Monitor Setup ' --input-label ' Input ' \
    --list-label ' Setups ' --preview-label ' File Preview ' \
    --preview-window 'right:70%' --height=100% \
    --preview="bat $SETUPS_DIR/{} --language toml --color=always --style=plain")

[[ -z "$pick" ]] && exit 1

if gum confirm "Are you sure you want to switch to $pick?" --default=true; then
    target_mon_file="$SETUPS_DIR/$pick"
    ln --verbose --symbolic --force "$target_mon_file" "$MON_SYM_LNK"

    if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
        hyprctl reload

        if gum confirm "Fix Hypr-Space 🌌 ?"; then
            fix-hypr-space.sh
        fi
    fi
fi
