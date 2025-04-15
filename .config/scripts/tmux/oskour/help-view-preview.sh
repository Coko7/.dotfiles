#!/usr/bin/env bash

source $SCRIPTS/bash-colors.sh

executable_name=$1

if help_text=$("$executable_name" --help 2>&1); then
    echo -e "$help_text" \
        | bat --color=always --paging=always --plain --language=help
else
    echo -e "${FG_RED}ERROR: ${COL_RESET}Incompatible command '$executable_name' "
    echo -e "\n(╯°□°)╯︵ ┻━┻"
    exit 0
fi
