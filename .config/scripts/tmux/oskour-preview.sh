#!/usr/bin/env bash

case "$1" in
    "cheat") description="Browse https://cheat.sh cheat sheets." ;;
    "help") description="View a program's help option." ;;
    "man") description="View a program's man page." ;;
    "tldr") description="Use TLDR pages to get started quickly with a program." ;;
    "xny") description="Learn syntax of a specific language/tool with 'Learn X in Y minutes'." ;;
    *) description="You are not supposed to ever see this -_-' ..." ;;

esac

echo "$1" | figlet | lolcat -f -S 42

echo -e "==============================\n" | lolcat -f -S 42

echo -e "$description"
