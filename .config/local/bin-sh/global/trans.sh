#!/usr/bin/env bash

source "$SCRIPTS/bash-colors.sh"

src_lang=""
dst_lang="fr"
if [ -n "$1" ]; then
    src_lang=$(echo "$1" | cut -d: -f1)
    dst_lang=$(echo "$1" | cut -d: -f2)
fi

if [ -z "$src_lang" ]; then
    echo "=== From ANY to $dst_lang ==="
else
    echo "=== From $src_lang to $dst_lang ==="
fi

text=$(gum input --prompt="Text> " --placeholder="Type text to translate...")
if [ -z "$text" ]; then
    exit 1
fi

res=$(gum spin --title="Translating..." -- trans --brief "$src_lang:$dst_lang" "$text")

echo -e "\n${FG_YELLOW}Original:${COL_RESET}"
echo "$text"

echo -e "\n${FG_CYAN}Translated:${COL_RESET}"
echo "$res"
