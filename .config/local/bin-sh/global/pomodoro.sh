#!/usr/bin/env bash

SOUND_DIR="/usr/share/sounds/freedesktop/stereo"
WORK_TIME="25m"
BREAK_TIME="5m"

function work() {
    timer $WORK_TIME -n "🍅 Pomodoro: Work time" --format 24h \
        && notify-send -u low "🍅 Break Time!" "Your $WORK_TIME work session has just ended" \
        -i "$HOME/Pictures/System/tomato.png" \
        -h string:x-canonical-private-synchronous:pomodoro-mine --transient \
        && paplay "$SOUND_DIR/complete.oga"
}

function rest() {
    timer $BREAK_TIME -n "🍅 Pomodoro: Break time" --format 24h \
        && notify-send -u low "🍅 Break is over!" "Get back to work" \
        -i "$HOME/Pictures/System/tomato.png" \
        -h string:x-canonical-private-synchronous:pomodoro-mine --transient \
        && paplay "$SOUND_DIR/complete.oga"
}

function show_help() {
    echo -e "Usage: pomodoro.sh OPTION\n"
    echo "-h, --help        display this help text and exit"
    echo "-w, --work        start $WORK_TIME work timer"
    echo "-r, --rest        start $BREAK_TIME break timer"
}

case "$1" in
    "-w"|"--work") work ;;
    "-r"|"--rest") rest ;;
    "-h"|"--help") show_help ;;
    *) show_help; exit 1 ;;
esac
