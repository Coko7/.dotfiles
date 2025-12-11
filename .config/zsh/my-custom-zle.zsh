#!/usr/bin/env zsh

# Custom ZLE widget to launch zoxide interactive with CTRL+E(xplore)
function zoxide_prompt_interactive() {
    zi
    zle reset-prompt
}
zle -N zoxide_prompt_interactive
bindkey '^J' zoxide_prompt_interactive

# Custom ZLE widget to launch yazi interactive with CTRL+N(avigate)
function yazi_interactive() {
    BUFFER="y"          # Set command line buffer to "y"
    zle .accept-line    # Call the original accept-line widget to execute
}
zle -N yazi_interactive
bindkey '^N' yazi_interactive

# Custom ZLE widget to launch neovim interactive with CTRL+T(ext Edit)
# function neovim_interactive() {
#     nvim
#     zle reset-prompt
# }
# zle -N neovim_interactive
# bindkey '^T' neovim_interactive

# Custom ZLE widget to copy current line to clipboard
function copy_line_to_clipboard() {
    print -r -- "$BUFFER" | wl-copy --trim-newline
}
zle -N copy_line_to_clipboard
bindkey '^Y' copy_line_to_clipboard

function _my_ollama_commit_msg_generator() {
    local msg
    msg=$(bash git-ai-commit-msg.sh) || msg=""
    # Append output without adding extra newlines or spaces
    BUFFER="${BUFFER}${msg}"
    # Move the cursor to the end of the buffer after appending
    CURSOR=$#BUFFER
    zle reset-prompt  # Force redraw of the line to show changes
}
zle -N _my_ollama_commit_msg_generator
bindkey '^ga' _my_ollama_commit_msg_generator

function _my_commit_messages_fzf() {
    local msg
    msg=$(git log --pretty=format:"%s" | fzf) || msg=""
    BUFFER="${BUFFER}${msg}"
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N _my_commit_messages_fzf
bindkey '^gc' _my_commit_messages_fzf

# Disabled because I use ZVM 'vv' mode instead for now
# Custom widget that uses nvim to edit cmd prompt
# function edit_with_nvim() {
#     # Use a unique temporary file
#     local tmpfile=$(mktemp /tmp/zsh_edit.XXXXXX)
#
#     # Write current buffer to the file
#     print -r -- "$BUFFER" > "$tmpfile"
#
#     # Open in Neovim
#     nvim "+set filetype=sh" "$tmpfile"
#
#     # Restore edited content back into ZLE buffer
#     BUFFER=$(<"$tmpfile")
#     CURSOR=${#BUFFER}
#
#     # Clean up
#     command rm "$tmpfile"
# }
# zle -N edit_with_nvim
# bindkey '^E' edit_with_nvim
