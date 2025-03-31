#!/usr/bin/env bash

select_cmd="fzf"
if [ -n "$1" ]; then
    select_cmd="fzf -f $1"
fi

spaces="Personal,Work"
pick=$(echo $spaces | tr ',' '\n' | $select_cmd --prompt="Pick env > ")

case $pick in
    "Personal") bash "$SCRIPTS/tmux/init-perso-env.sh" ;;
    "Work") bash "$SCRIPTS/tmux/init-work-env.sh" ;;
    *) return 1 ;;
esac
