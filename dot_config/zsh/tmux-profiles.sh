#!/usr/bin/env bash

# ⚠️ Make sure those env vars are set here properly BEFORE we set _ZO_EXCLUDE_DIRS
# If theses variables are unset, this might result in clearing the entire Z database

if [ ! -v WORKSPACE ]; then
    echo "tmux-profiles.sh: error, WORKSPACE not set"
    return 1
fi

if [ ! -v PROJ_PERSO ]; then
    echo "tmux-profiles.sh: error, PROJ_PERSO not set"
    return 1
fi

if [ ! -v PROJ_WORK ]; then
    echo "tmux-profiles.sh: error, PROJ_WORK not set"
    return 1
fi

# Custom function to only add path to list of paths if NOT in there already
function __add_once() {
    local entry="$1"
    local path_list="$2"

    case ":$path_list:" in
        *:"$entry":*)
            # Already in path list, do nothing
            ;;
        *)
            # Else: add to path list
            path_list="$path_list:$entry"
            ;;
    esac

    echo "$path_list"
}

PATH=$(__add_once "$XDG_CONFIG_HOME/local/bin-sh/global" "$PATH")

if [ "$TMUX_WS_TYPE" = "PERSO" ]; then # Perso profile
    export BROWSER='perso-web-browser.sh'

    # QMK
    export QMK_HOME=$PROJ_PERSO/Programming/qmk_firmware

    # custom scripts
    PATH=$(__add_once "$XDG_CONFIG_HOME/local/bin-sh/personal" "$PATH")

    # zsh history
    export HISTFILE="$ZDOTDIR/history/personal/zhistory"

    # setup zoxide
    export _ZO_DATA_DIR="$XDG_DATA_HOME/zoxide/perso"

    _ZO_EXCLUDE_DIRS=$(__add_once "$PROJ_WORK/*" "$_ZO_EXCLUDE_DIRS")
    _ZO_EXCLUDE_DIRS=$(__add_once "$HOME/Downloads/Work/*" "$_ZO_EXCLUDE_DIRS")
    _ZO_EXCLUDE_DIRS=$(__add_once "$HOME/Pictures/Work/*" "$_ZO_EXCLUDE_DIRS")

    # setup starship
    export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship-perso.toml"

    # dajo.sh -- daily journal
    export DAJO_ENTRY_DIR="$PROJ_PERSO/Notes/journal"

elif [ "$TMUX_WS_TYPE" = "WORK" ]; then # Work profile
    export BROWSER='work-web-browser.sh'

    # custom scripts
    PATH=$(__add_once "$XDG_CONFIG_HOME/local/bin-sh/work" "$PATH")

    # zsh history
    export HISTFILE="$ZDOTDIR/history/work/zhistory"

    # setup zoxide
    export _ZO_DATA_DIR="$XDG_DATA_HOME/zoxide/work"

    _ZO_EXCLUDE_DIRS=$(__add_once "$PROJ_PERSO/*" "$_ZO_EXCLUDE_DIRS")
    _ZO_EXCLUDE_DIRS=$(__add_once "$HOME/Downloads/Personal/*" "$_ZO_EXCLUDE_DIRS")
    _ZO_EXCLUDE_DIRS=$(__add_once "$HOME/Pictures/Wallpapers/*" "$_ZO_EXCLUDE_DIRS")

    # setup starship
    export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship-work.toml"

    # dajo.sh -- daily journal (worklog)

    # source useful stuff
    source "$PROJ_WORK/config/source_me.sh"

    # register custom jira zsh keybind
    source "$PROJ_WORK/config/jira-zsh-cmd.zsh"

elif [ "$TMUX_WS_TYPE" = "DEMO" ]; then # Demo profile

    # custom scripts
    PATH=$(__add_once "$XDG_CONFIG_HOME/local/bin-sh/work" "$PATH")

    # zsh history
    export HISTFILE="$ZDOTDIR/history/demo/zhistory"

    # setup zoxide
    export _ZO_DATA_DIR="$XDG_DATA_HOME/zoxide/work"

    _ZO_EXCLUDE_DIRS=$(__add_once "$PROJ_PERSO/*" "$_ZO_EXCLUDE_DIRS")
    _ZO_EXCLUDE_DIRS=$(__add_once "$HOME/Downloads/Personal/*" "$_ZO_EXCLUDE_DIRS")
    _ZO_EXCLUDE_DIRS=$(__add_once "$HOME/Pictures/Wallpapers/*" "$_ZO_EXCLUDE_DIRS")

    # setup starship
    export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship-demo.toml"

else # Default: unknown tmux env OR not using tmux
    export BROWSER='perso-web-browser.sh'

    # zsh history
    export HISTFILE="$ZDOTDIR/history/zhistory"

    # setup zoxide
    export _ZO_DATA_DIR="$XDG_DATA_HOME/zoxide"

    # setup starship
    export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
fi

export _ZO_EXCLUDE_DIRS
export PATH
