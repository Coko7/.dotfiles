#!/usr/bin/env bash

fd -e png -e jpg . | fzf \
    --tmux 100%,100% \
    --preview-window=right:90% \
    --preview="echo image: {}; ascii-image-converter {} --width 100 --color --braille"
