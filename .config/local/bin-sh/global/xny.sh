#!/usr/bin/env bash

# The xny_langs.json is a modified copy of: https://github.com/YesSeri/xny-cli/blob/417a25258ee3b8b9a46a05f43f0a355bf94b6815/data.json

BASE_URL="https://learnxinyminutes.com"
XNY_DATA=$(jq '.' "$XDG_CONFIG_HOME/local/bin-sh/global/data/xny_langs.json")

function display_lang_docs() {
    local lang_code=$1
    local lang_url=$2

    full_url="$BASE_URL$lang_url"

    local bat_lang_code
    bat_lang_code=$(bat --list-languages | grep -i "^$lang_code:" \
        | cut -d':' -f2 | cut -d',' -f1)

    if [ -n "$bat_lang_code" ]; then
        curl -s "$full_url" | bat -l "$bat_lang_code" -n
    else
        curl -s "$full_url" | bat -n
    fi
}

function find_lang() {
    local input=$1
    echo "$XNY_DATA" | jq --arg lang "$input" -r '.[] | select(.name == $lang) | .source_code_link'
}

# If arg is provided, try to find the language
if [ -n "$1" ]; then
    input=$1
    xny_link=$(find_lang "$input")
    if [ -n "$xny_link" ]; then
        display_lang_docs "$input" "$xny_link"
    else
        echo "xny: no such lang '$input'" >&2
        exit 1
    fi
    exit 0
fi

# If no arg provided, go into interactive mode
xny_lang=$(echo "$XNY_DATA" | jq -r '.[].name' | gum filter --prompt="Choose> ")
if [ -n "$xny_lang" ]; then
    xny_link=$(find_lang "$xny_lang")
    display_lang_docs "$xny_lang" "$xny_link"
fi
