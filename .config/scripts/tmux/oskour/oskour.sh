#!/usr/bin/env bash

options=$(cat "$SCRIPTS/tmux/oskour/options.txt")
pick=$(echo -e "$options" \
    | fzf --exact --prompt="Oskour type> " \
    --preview="$SCRIPTS/tmux/oskour/oskour-preview.sh {}")
if [ -z "$pick" ]; then
    exit 0
fi

pick_name=$(echo "$pick" | cut -d':' -f1)
case $pick_name in
    "cheat") "$SCRIPTS/tmux/oskour/cheat-view.sh" ;;
    "help") "$SCRIPTS/tmux/oskour/help-view.sh" ;;
    "man") "$SCRIPTS/tmux/oskour/man-view.sh" ;;
    "tldr") "$SCRIPTS/tmux/oskour/tldr-view.sh" ;;
    "xny") xny.sh ;;
    *)
esac
