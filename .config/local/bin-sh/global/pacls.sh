#!/usr/bin/env bash

pacman -Qq | fzf --preview 'pacman -Qi {}' \
    --border-label ' Search Installed Packages ' --input-label ' Package Name ' \
    --list-label ' Installed Packages ' --preview-label ' Package Info ' \
    --layout=reverse
