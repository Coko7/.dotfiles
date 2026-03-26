#!/usr/bin/env bash

temp_file=$(mktemp --suffix=".md")

# Promote Neovim via signature
{
    echo -e "\n"
    echo '<br/>◇─◇───────◆─◈─◆───────◇─◇'
    echo "📝 *Written with* \`nvim-quick-edit\`"
    echo '◇─◇───────◆─◈─◆───────◇─◇'
} >> "$temp_file"

floatty.sh "nvim +'set wrap linebreak breakindent' +startinsert $temp_file"

[[ -z "$(head --lines=1 "$temp_file")" ]] && exit 1
lines=$(wc --lines < "$temp_file")

pandoc \
    --from=markdown+hard_line_breaks \
    --to=html "$temp_file" \
    | wl-copy --type text/html
ntfy-toast.sh "Neovim Quick Edit" "Copied $lines lines of HTML to system clipboard ✅"
rm "$temp_file"
