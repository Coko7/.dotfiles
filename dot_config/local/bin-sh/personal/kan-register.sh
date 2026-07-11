#!/usr/bin/env bash

metadatas_path=$(kanumi config show --json | jq -r '.meta_path')

while true; do
    pick=$(kanumi scan --json | jq -r '.new[]' | fzf \
        --border-label ' Kanumi Interactive Register ' --input-label ' Input ' \
        --list-label ' Unregistered Images ' --preview-label ' Image Preview ' \
        --preview="$SCRIPTS/fzf-preview.sh {}" --height 80% \
        --preview-window=down:40%)
    if [ -z "$pick" ]; then
        exit 1
    fi

    # kitten icat "$pick"
    score=$(seq 0 10 | fzf \
        --border-label ' Kanumi Register ' --input-label ' Input ' \
        --list-label ' Boxa Scores ' --preview-label ' Image Preview ' \
        --preview="$SCRIPTS/fzf-preview.sh $pick" --height 80%)
    if [ -z "$score" ]; then
        exit 1
    fi

    all_metas=$(cat "$metadatas_path")
    if raw_json=$(kanumi meta gen "$pick"); then
        json=$(echo "$raw_json" | jq)
        new_json=$(echo "$json" | jq -c --argjson val "$score" '.scores += [{"name":"boxa", "value": $val}]')
        all_metas=$(echo "$all_metas" | jq -c --argjson obj "$new_json" '. += [$obj]')
        echo "$all_metas" > "$metadatas_path"
    fi
done
