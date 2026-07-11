#!/usr/bin/env bash

wr_trans_key="$1"
if [ -z "$1" ]; then
    choice=$(echo -e "English -> Français\nFrançais -> English\nEnglish -> Svenska\nSvenska -> English" \
        | fzf \
        | sed 's/ -> /:/')

    src=$(echo "$choice" | cut -d: -f1 | sed -E 's/\b([A-Za-z]{2})([A-Za-z]*)\b/\L\1/g')
    dst=$(echo "$choice" | cut -d: -f2 | sed -E 's/\b([A-Za-z]{2})([A-Za-z]*)\b/\L\1/g')
    wr_trans_key="$src$dst"
fi

exp="$2"
if [ -z "$2" ]; then
    exp=$(gum input --prompt="Text> " --placeholder="Type text to translate...")
fi

query=$(url.sh --encode "$exp")
$BROWSER "https://www.wordreference.com/$wr_trans_key/$query"
# w3m "https://www.wordreference.com/$wr_trans_key/$query"
