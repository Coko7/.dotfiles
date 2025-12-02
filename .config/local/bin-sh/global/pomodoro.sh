#!/usr/bin/env bash

SOUND_DIR="/usr/share/sounds/freedesktop/stereo"
DEFAULT_WORK_TIME="30m"
DEFAULT_BREAK_TIME="5m"

function work() {
    [[ -z "$1" ]] && echo "error: expects work time to be passed as \$1" && exit 1
    timer "$1" -n "🍅 Pomodoro: Work time" --format 24h \
        && notify-send -u low "🍅 Break Time!" "Your $1 work session has just ended" \
        -i "$HOME/Pictures/System/tomato.png" \
        -h string:x-canonical-private-synchronous:pomodoro-mine --transient \
        && paplay "$SOUND_DIR/complete.oga"
}

function rest() {
    [[ -z "$1" ]] && echo "error: expects rest time to be passed as \$1" && exit 1
    timer "$1" -n "🍅 Pomodoro: Break time" --format 24h \
        && notify-send -u low "🍅 Break is over!" "Get back to work" \
        -i "$HOME/Pictures/System/tomato.png" \
        -h string:x-canonical-private-synchronous:pomodoro-mine --transient \
        && paplay "$SOUND_DIR/complete.oga"
}

function show_help() {
    echo -e "Usage: pomodoro.sh OPTION\n"
    echo "-h, --help        display this help text and exit"
    echo "-w, --work        start $DEFAULT_WORK_TIME work timer"
    echo "-r, --rest        start $DEFAULT_BREAK_TIME break timer"
}

case "$1" in
    "-w"|"--work")
        work_time=${2:-$DEFAULT_WORK_TIME}
        work "$work_time"
        ;;
    "-r"|"--rest")
        rest_time=${2:-$DEFAULT_REST_TIME}
        rest "$rest_time"
        ;;
    "-h"|"--help") show_help ;;
    *) show_help; exit 1 ;;
esac
