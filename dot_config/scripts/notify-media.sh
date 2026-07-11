#!/usr/bin/env bash

function get_meta() {
    local player=$1
    local key=$2
    playerctl -p "$player" metadata --format "{{$key}}"
}

function show_notif() {
    local player=$1
    local title album artist art_url media_status
    local notif_id=$2

    title=$(get_meta "$player" "title")
    album=$(get_meta "$player" "album")
    artist=$(get_meta "$player" "artist")
    art_url=$(get_meta "$player" "mpris:artUrl")

    local body=""

    if [[ -n "$album" ]]; then
        body="$body$album\n"
    fi

    body="$body$artist"

    # image has to be downloaded
    if [[ $art_url == http* ]]; then
        temp_file=$(mktemp --suffix=.jpg)
        wget -q -O "$temp_file" "$art_url"
        img=$temp_file
    else
        img=$art_url
    fi

    # use fallback image if none available
    if [ ! -f "$img" ]; then
        img="$HOME/Pictures/System/music.jpg"
    fi

    notify-send -u low "$title" "$body" \
        -i "$img" -t 2000 \
        -h "string:x-canonical-private-synchronous:cur-media-$notif_id" --transient
}

if [ -n "$1" ]; then
    show_notif "$1" 1
    exit 0
fi

id=0
players=$(playerctl -l)
for player in $players; do
    status=$(playerctl -p "$player" status)
    if [[ "$status" == "Playing" ]]; then
        ((id++))
        show_notif "$player" $id
    fi
done
