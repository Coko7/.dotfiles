#!/usr/bin/env bash

# Temporary file paths
IMG_PATH="/tmp/ocr_screenshot_$$.png"
TESSE_TXT_PATH="/tmp/ocr_text_$$"
TXT_PATH="/tmp/ocr_text_$$.txt"

if ! grim -g "$(slurp)" "$IMG_PATH"; then
    notify-send -u low "Oh Captain, Read!" "It was cancelled 💀" \
        -i "$HOME/Pictures/System/ocr.jpg" -t 2000 \
        -h "string:x-canonical-private-synchronous:ocr-notif" --transient
    exit 0
fi

# Preprocess image for better OCR
# magick "$IMG_PATH" -resize 400% "$IMG_PATH"

if ! tesseract "$IMG_PATH" "$TESSE_TXT_PATH" &> /dev/null; then
    echo "tesseract failed to process: $IMG_PATH"
    exit 1
fi

notify-send -u low "Oh Captain, Read!" "Got some text🚀" \
    -i "$HOME/Pictures/System/ocr.jpg" -t 2000 \
    -h "string:x-canonical-private-synchronous:ocr-notif" --transient

# Copy result to clipboard
# cat "$TXT_PATH" | wl-copy

xdg-open "$TXT_PATH"
sleep 0.5s

rm -f "$IMG_PATH" "$TXT_PATH"
