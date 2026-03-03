#!/usr/bin/env bash

hyprctl -j monitors | jq --raw-output '.[] | [.name, .x, .description] | @tsv' \
  | sort --numeric-sort --key=2 \
  | column --table --separator $'\t'
