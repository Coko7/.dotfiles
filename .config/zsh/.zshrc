#!/usr/bin/env zsh

fpath=($XDG_CONFIG_HOME/zsh/plugins $fpath)

# +------------------------+
# | TMUX ENVIRONMENT SETUP |
# +------------------------+

source $ZDOTDIR/tmux-profiles.sh

# +------------+
# | NAVIGATION |
# +------------+

#setopt AUTO_CD              # Go to folder path without using cd.

setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

setopt CORRECT              # Spelling correction
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt EXTENDED_GLOB        # Use extended globbing syntax.

# +---------+
# | HISTORY |
# +---------+

setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.

# +---------+
# | ALIASES |
# +---------+

for f in $XDG_CONFIG_HOME/aliases/*.sh; do source "$f"; done

# +-----------+
# | VI KEYMAP |
# +-----------+

# Vi mode
bindkey -v
export KEYTIMEOUT=40
bindkey '^R' history-incremental-search-backward

# +------------+
# | COMPLETION |
# +------------+

source $ZDOTDIR/completion.zsh
autoload -U compinit; compinit

# +---------+
# | PLUGINS |
# +---------+

# syntax highlighting (with catppuccin theme)
source $ZDOTDIR/plugins/catppuccin_macchiato-zsh-syntax-highlighting.zsh
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# +-----+
# | FZF |
# +-----+

source <(fzf --zsh)

# Custom keybind shortcuts for Git
source $ZDOTDIR/plugins/fzf-git/fzf-git.sh

# +------+
# | RUST |
# +------+

source $CARGO_HOME/env

# +--------------+
# | SHELL PROMPT |
# +--------------+

eval "$(starship init zsh)"

# +--------+
# | ZOXIDE |
# +--------+

eval "$(zoxide init zsh)"

# zsh parameter completion for the dotnet CLI

_dotnet_zsh_complete()
{
  local completions=("$(dotnet complete "$words")")

  # If the completion list is empty, just continue with filename selection
  if [ -z "$completions" ]
  then
    _arguments '*::arguments: _normal'
    return
  fi

  # This is not a variable assignment, don't remove spaces!
  _values = "${(ps:\n:)completions}"
}

compdef _dotnet_zsh_complete dotnet
