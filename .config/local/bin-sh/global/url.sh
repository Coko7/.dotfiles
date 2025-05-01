#!/usr/bin/env bash

# Credit to @jkishner for https://gist.github.com/jkishner/2fccb24640a27c2d7ac9
#
# Also interesting: https://gist.github.com/cdown/1163649

function url_encode() {
    echo "$1" | sed \
        -e 's/%/%25/g'  -e 's/ /%20/g'  -e 's/!/%21/g'  \
        -e 's/"/%22/g'  -e "s/'/%27/g"  -e 's/#/%23/g'  \
        -e 's/(/%28/g'  -e 's/)/%29/g'  -e 's/+/%2b/g'  \
        -e 's/,/%2c/g'  -e 's/-/%2d/g'  -e 's/:/%3a/g'  \
        -e 's/;/%3b/g'  -e 's/?/%3f/g'  -e 's/@/%40/g'  \
        -e 's/\$/%24/g' -e 's/\&/%26/g' -e 's/\*/%2a/g' \
        -e 's/\./%2e/g' -e 's/\//%2f/g' -e 's/\[/%5b/g' \
        -e 's/\\/%5c/g' -e 's/\]/%5d/g' -e 's/\^/%5e/g' \
        -e 's/_/%5f/g'  -e 's/`/%60/g'  -e 's/{/%7b/g'  \
        -e 's/|/%7c/g'  -e 's/}/%7d/g'  -e 's/~/%7e/g'
}

function url_decode() {
    echo "$1" | sed \
        -e 's/%25/%/g'  -e 's/%20/ /g'  -e 's/%21/!/g'  \
        -e 's/%22/"/g'  -e "s/%27/'/g"  -e 's/%23/#/g'  \
        -e 's/%28/(/g'  -e 's/%29/)/g'  -e 's/%2b/+/g'  \
        -e 's/%2c/,/g'  -e 's/%2d/-/g'  -e 's/%3a/:/g'  \
        -e 's/%3b/;/g'  -e 's/%3f/?/g'  -e 's/%40/@/g'  \
        -e 's/%24/\$/g' -e 's/%26/\&/g' -e 's/%2a/\*/g' \
        -e 's/%2e/\./g' -e 's/%2f/\//g' -e 's/%5b/\[/g' \
        -e 's/%5c/\\/g' -e 's/%5d/\]/g' -e 's/%5e/\^/g' \
        -e 's/%5f/_/g'  -e 's/%60/`/g'  -e 's/%7b/{/g'  \
        -e 's/%7c/|/g'  -e 's/%7d/}/g'  -e 's/%7e/~/g'
}

function show_help() {
    echo "Usage: url.sh <MODE> [DATA]"
    echo "Modes:"
    echo " -e, --encode             perform URL encode on the data"
    echo " -d, --decode             perform URL decode on the data"
    echo " -h, --help               display this help text and exit"
}

mode=$1
case "$mode" in
    '-e'|'--encode') 
        input=${2:-$(< /dev/stdin)}
        url_encode "$input"
        ;;
    '-d'|'--decode') 
        input=${2:-$(< /dev/stdin)}
        url_decode "$input"
        ;;
    '-h'|'--help')
        show_help
        ;;
    *)
        show_help
        exit 1
        ;;
esac
