#!/usr/bin/env zsh

###############################
# EXPORT ENVIRONMENT VARIABLE #
###############################

# export TERM='kitty'
export TERM='xterm-ghostty'

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

# PATH
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$XDG_CONFIG_HOME/local/bin-sh/global/"
export PATH="$PATH:$HOME/.dotnet/tools"
export PATH="$PATH:$HOME/.npm-global"

# X11
export XINITRC="$XDG_CONFIG_HOME/X11/.xinitrc"

# editor
export EDITOR="nvim"
export VISUAL="nvim"

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

# prompt
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"

# rust
export RUSTUP_HOME="$XDG_CONFIG_HOME/rustup"
export CARGO_HOME="$XDG_CONFIG_HOME/cargo"

# Man pages
export MANPAGER='nvim +Man!'

# NPM
export NPM_PATH="$XDG_CONFIG_HOME/node_modules"
export NPM_BIN="$XDG_CONFIG_HOME/node_modules/bin"
export NPM_CONFIG_PREFIX="$XDG_CONFIG_HOME/node_modules"

# Minecraft (Prism Launcher)
export MC_PRISM="$HOME/.var/app/org.prismlauncher.PrismLauncher"
export MC_PRISM_INST="$MC_PRISM/data/PrismLauncher/instances"
export MC_PRISM_1_21="$MC_PRISM_INST/1.21/.minecraft"
export MC_PRISM_LATEST="$MC_PRISM_1_21"

# FZF

export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard || fd --type f"
# Open in tmux popup (centered) if on tmux, otherwise use --height mode
# Set color theme to Catppuccin Mocha theme
export FZF_DEFAULT_OPTS=" \
    --style=full --layout reverse --border --padding 1,2 --height 80% --tmux 80% \
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="
    --walker-skip .git,node_modules,target
    --preview '$SCRIPTS/fzf-preview.sh {}'
    --border-label ' Search files ' --input-label ' Input '
    --header-label ' File Type '
    --bind 'focus:transform-preview-label:[[ -n {} ]] && printf \" Previewing [%s] \" {}'
    --bind 'focus:+transform-header:file --brief {} || echo \"No file selected\"' \
    --bind 'focus:transform-header:file --brief {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
    --bind 'ctrl-y:execute-silent(echo -n {2..} | wl-copy)+abort'
    --color header:italic
    --header 'Press CTRL-Y to copy command into clipboard'"

# zoxide
export _ZO_EXCLUDE_DIRS="$HOME/Documents/private/*"
TREE_CMD="eza --color=always --icons --group-directories-first --tree --level=3"
export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS \
    --border-label ' Zoxide Interactive ' --input-label ' Input ' \
    --list-label ' Jump List ' --preview-label ' Directory Structure ' \
    --preview=\"echo {} | awk '{print \$2}' | xargs $TREE_CMD\""

# Personal
export SCRIPTS="$XDG_CONFIG_HOME/scripts"
export WALLPAPERS_DIR="$HOME/Pictures/Wallpapers"
export WORKSPACE="$HOME/Workspace"
export PROJ_PERSO="$WORKSPACE/personal"

# QMK
export QMK_HOME=$PROJ_PERSO/Programming/qmk_firmware

# Work
export PROJ_WORK="$WORKSPACE/work"
export WALLPAPERS_DIR="$HOME/Pictures/Wallpapers"
