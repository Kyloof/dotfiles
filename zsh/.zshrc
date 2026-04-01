#!/bin/sh

# useful options (zshoptions)
unsetopt BEEP
zle_highlight=('paste:none')

# completions
source $ZDOTDIR/completion.zsh
fpath=(~/.zsh/zsh-completions/src $fpath)

# aliases
source "$ZDOTDIR/aliases.zsh"

# prompt
source "$ZDOTDIR/prompt.zsh"

# enable Vi mode
bindkey -v
export KEYTIMEOUT=1

# source functions.zsh
source "$ZDOTDIR/functions.zsh"

# zsh plugins
zsh_add_plugin "sharkdp/lscolors"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"


# "bat" as manpager
export MANPAGER="sh -c 'col -b | bat -l man -p'"
