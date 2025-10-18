#!/usr/bin/env bash
# Set of frequently used bash functions

function jstc() {
    local sed_exp='/^[[:blank:]]*#/d;s/\/\/.*//'

    if [ -n "$1" ]; then
        sed $sed_exp $1
    else
        cat | sed $sed_exp
    fi
}

#
# Credit to @jkishner for https://gist.github.com/jkishner/2fccb24640a27c2d7ac9
#
# Also interesting: https://gist.github.com/cdown/1163649
#
function urle() {
    local input="${@:-$(< /dev/stdin)}"

    echo $input \
    | sed \
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

function urld() {
    local input="${@:-$(< /dev/stdin)}"

    echo $input \
    | sed \
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
