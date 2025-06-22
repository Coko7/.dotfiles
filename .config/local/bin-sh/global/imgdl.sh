#!/usr/bin/env bash

echo "IMG-DL" | figlet | lolcat -S 11

url=$(gum input --prompt="🌐 URL> " --placeholder "Paste URL")
if [ -z "$url" ]; then
    exit 1
fi

echo "🌐 URL> $url"

default_filename=$(echo "$url" | rev | cut -d'/' -f1 | rev)
filename=$(gum input --prompt="🖼️ Save to> " --value "$default_filename")
if [ -z "$filename" ]; then
    exit 1
fi

echo "🖼️ Save to> $filename"

if [ -e "$filename" ]; then
    echo "imgdl: error: file already exists: $filename" >&2
    exit 1
fi

gum spin --title="🚀 Downloading $filename..." -- wget -O "$filename" "$url"
