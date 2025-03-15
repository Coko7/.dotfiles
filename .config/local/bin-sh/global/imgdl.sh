#!/usr/bin/env bash

url=$(gum input --prompt="URL> " --placeholder "Paste URL")
if [ -z "$url" ]; then
    exit 1
fi

echo "URL> $url"

filename=$(gum input --prompt="Save to> " --placeholder "example.png")
if [ -z "$filename" ]; then
    exit 1
fi

echo "Save to> $filename"

if [ -e "$filename" ]; then
    echo "imgdl: error: file already exists: $filename" >&2
    exit 1
fi

gum spin --title="Downloading $filename..." -- wget -O "$filename" "$url"
