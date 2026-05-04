# set XDG base directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# set neovim as default editor
export EDITOR="nvim"
export SUDOEDITOR="nvim"
export VISUAL="nvim"

# set ZDOTDIR
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# set history files
export HISTFILE="$ZDOTDIR/.zhistory"    # history filepath
export HISTSIZE=10000                   # maximum events for internal history
export SAVEHIST=10000                   # maximum events in history file
# . "$HOME/.cargo/env"
