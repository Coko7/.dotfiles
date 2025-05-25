#!/usr/bin/env bash

options=$(cat "$SCRIPTS/tmux/oskour/options.txt")
pick=$(echo -e "$options" | fzf --exact \
    --border-label ' Oskour: Interactive Help Fuzzer ' --input-label ' Input ' \
    --list-label ' Oskour Modes ' --preview-label ' Mode Preview ' \
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
    "xny") "$SCRIPTS/tmux/oskour/xny-view.sh" ;;
    *)
esac
