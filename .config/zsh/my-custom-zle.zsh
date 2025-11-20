#!/usr/bin/env zsh

# Custom ZLE widget to launch zoxide interactive with CTRL+E(xplore)
function zoxide_prompt_interactive() {
    zi
    zle reset-prompt
}
zle -N zoxide_prompt_interactive
bindkey '^E' zoxide_prompt_interactive

# Custom ZLE widget to launch yazi interactive with CTRL+N(avigate)
function yazi_interactive() {
    BUFFER="y"          # Set command line buffer to "y"
    zle .accept-line    # Call the original accept-line widget to execute
}
zle -N yazi_interactive
bindkey '^N' yazi_interactive

# Custom ZLE widget to launch neovim interactive with CTRL+T(ext Edit)
function neovim_interactive() {
    nvim
    zle reset-prompt
}
zle -N neovim_interactive
bindkey '^T' neovim_interactive

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
