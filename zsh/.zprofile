#!/usr/bin/env zsh

typeset -U path

path=(
    $HOME/.local/bin
    $HOME/.local/bin/scripts/
    $path
)

