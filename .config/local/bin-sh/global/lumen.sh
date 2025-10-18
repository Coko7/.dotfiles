#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "provide brightness level"
    exit 1
fi

level=$1

gum spin --title="💡 Setting brightness to $level..." -- ddcutil setvcp 10 "$level" && \
    brightnessctl set "${level}%"
