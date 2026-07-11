#!/usr/bin/env bash

DEFAULT_ROOT_DIR="$HOME"
root_search_dir=${1:-$DEFAULT_ROOT_DIR}
[[ -z "$root_search_dir" ]] && echo "error: expects root search dir" && exit 1

target_file=$(fdz.sh "$root_search_dir")
[[ -z "$target_file" ]] && exit 1

target_file="$root_search_dir/$target_file"
[[ ! -f "$target_file" ]] && echo "error: not a file: $target_file" && exit 1

target_filename=$(basename "$target_file")

link_name=$2
if [ -z "$link_name" ]; then
    link_name=$(gum input --prompt="Symlink> " --value="$target_filename")
fi

[[ -z "$link_name" ]] && exit 1

gum confirm "🔗 Create \"$link_name\" -> \"$target_filename\" ?" || exit 1
ln --symbolic --verbose "$target_file" "$link_name"
