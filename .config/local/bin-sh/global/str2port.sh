#!/usr/bin/env bash

input="$1"

hash=$(echo -n "$input" | md5sum | awk '{print $1}')

# Convert first 8 characters of the hash from hex to decimal
num=$((16#${hash:0:8}))

range=$((49151 - 1024 + 1))
port=$((1024 + (num % range)))

echo $port
