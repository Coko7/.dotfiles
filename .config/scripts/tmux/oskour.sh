#!/usr/bin/env bash

pick=$(echo -e "help\nman\ntldr\nxny" \
    | fzf --prompt="Oskour type> " \
    --preview="echo {} | figlet | lolcat -f -S 42")
if [ -z "$pick" ]; then
    exit 1
fi

case $pick in
    "help") "$SCRIPTS/tmux/help-view.sh" ;;
    "man") "$SCRIPTS/tmux/man-view.sh" ;;
    "tldr") "$SCRIPTS/tmux/tldr-view.sh" ;;
    "xny") xny.sh ;;
    *)
esac
