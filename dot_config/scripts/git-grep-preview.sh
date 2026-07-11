#!/usr/bin/env bash

file_selection=$1
pattern=$2

file=$(echo "$file_selection" | cut -d':' -f1)
line=$(echo "$file_selection" | cut -d':' -f2)

if [ ! -f "$file" ]; then
    echo "error: File '$file' does not exist." >&2
    exit 1
fi

context_size=20
start=$((line - context_size))
if [ $start -lt 0 ]; then
    start=0
fi

end=$((line + context_size))
total_lines=$(wc -l < "$file")
if [ $end -gt "$total_lines" ]; then
    end=$total_lines
fi

echo "File: $file"
echo "Pattern: $pattern"
echo ""

bat --color=always --style=numbers -H "$line" -r "$start:$end" "$file"
