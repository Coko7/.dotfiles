#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "provide brightness level"
    exit 1
fi

level=$1
re='^[0-9]+$'
if ! [[ $level =~ $re ]] ; then
   echo "error: provide a number" >&2; exit 1
fi

gum spin --title="💡 Setting brightness to $level..." \
    -- ddcutil setvcp 10 "$level" \
    && brightnessctl set "${level}%"
