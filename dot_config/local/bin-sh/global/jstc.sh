#!/usr/bin/env bash

# Strip comments from .jsonc file

sed_exp='/^[[:blank:]]*#/d;s/\/\/.*//'

if [ -n "$1" ]; then
    sed "$sed_exp" "$1"
else
    cat | sed "$sed_exp"
fi
