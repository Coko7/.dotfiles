#!/usr/bin/env bash

CURRENT_LAYOUT=$(hyprkeyb.sh get-active-layout)

value=""
case $CURRENT_LAYOUT in
    "English (US)") value="QWE" ;;
    "French") value="AZE" ;;
    "English (Dvorak)") value="DVO" ;;
    "French (Ergo‑L)") value="Ergo-L" ;;
    *) value="$CURRENT_LAYOUT" ;;
esac

echo "{\"text\": \"$value\", \"tooltip\": \"$CURRENT_LAYOUT\" }"
