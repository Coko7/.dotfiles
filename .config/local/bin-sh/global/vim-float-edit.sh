#!/usr/bin/env bash

temp_file=$(mktemp --suffix=".md")
floatty.sh "nvim +'set wrap linebreak breakindent' +startinsert $temp_file"

[[ -z "$(head --lines=1 "$temp_file")" ]] && exit 1

lines=$(wc --lines < "$temp_file")
wl-copy < "$temp_file"
ntfy-toast.sh "Neovim Quick Edit" "Copied $lines lines of text to system clipboard ✅"
rm "$temp_file"
