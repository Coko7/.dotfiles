#!/usr/bin/env bash

stdin=$(cat -)
entries=$(echo -e "$stdin" | envsubst)

input=$1

select_cmd="fzf"
if [ -n "$input" ]; then
    select_cmd="fzf -f $input"
fi

if ! pick=$(echo -e "$entries" | $select_cmd | head -n 1); then
    return 1
fi

res=$(echo "$pick" | cut -d':' -f2- | xargs)
echo "$res"
