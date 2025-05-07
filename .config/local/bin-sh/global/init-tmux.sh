#!/usr/bin/env bash

function activate_tmux_env() {
    case $1 in
        "Personal") bash "$SCRIPTS/tmux/init-perso-env.sh" ;;
        "Work")     bash "$SCRIPTS/tmux/init-work-env.sh" ;;
        "Demo")     bash "$SCRIPTS/tmux/init-demo-env.sh" ;;
        *) exit 1 ;;
    esac
}

select_cmd="fzf --multi"
if [ -n "$1" ]; then
    select_cmd="fzf -f $1"
fi

spaces="Personal\nWork\nDemo"
pick=$(echo -e "$spaces" | $select_cmd --prompt="Pick env > " --preview="echo {} | figlet")

for env_name in $pick; do
    echo "activating: $env_name"
    activate_tmux_env "$env_name"
done

if tmux has-session 2>/dev/null; then
    if gum confirm "Attach to tmux?"; then
        tmux attach
    fi
fi
