#!/bin/sh

# useful options (zshoptions)
unsetopt BEEP
zle_highlight=('paste:none')

# completions
source $ZDOTDIR/completion.zsh

fpath=(~/.zsh/zsh-completions/src $fpath)



# source aliases
source "$ZDOTDIR/aliases"

# directories stack
setopt AUTO_PUSHD           # push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # do not store duplicates in the stack.
setopt PUSHD_SILENT         # do not print the directory stack after pushd or popd.

# enable Vi mode
bindkey -v
export KEYTIMEOUT=1


# source functions.zsh
source "$ZDOTDIR/functions.zsh"

# zsh plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
