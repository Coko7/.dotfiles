#!/usr/bin/env bash

file_path=$1
line_num=$2
syntax=$3

if [ -z "$line_num" ]; then
    line_num=0
fi

if [ -z "$syntax" ]; then
    syntax="${file_path##*.}"
fi

nvim - +"$line_num" -c "set ft=$syntax" < "$file_path"
