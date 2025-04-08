#!/usr/bin/env bash

pick=$(echo -e "cheat\nhelp\nman\ntldr\nxny" \
    | fzf --prompt="Oskour type> " \
    --preview="$SCRIPTS/tmux/oskour-preview.sh {}")
if [ -z "$pick" ]; then
    exit 0
fi

case $pick in
    "cheat") "$SCRIPTS/tmux/cheat-view.sh" ;;
    "help") "$SCRIPTS/tmux/help-view.sh" ;;
    "man") "$SCRIPTS/tmux/man-view.sh" ;;
    "tldr") "$SCRIPTS/tmux/tldr-view.sh" ;;
    "xny") xny.sh ;;
    *)
esac
