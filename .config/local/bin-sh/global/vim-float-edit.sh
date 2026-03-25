#!/usr/bin/env bash

temp_file=$(mktemp --suffix=".md")
floatty.sh "nvim +'set wrap linebreak breakindent' +startinsert $temp_file"
wl-copy < "$temp_file"
rm "$temp_file"
