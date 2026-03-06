#!/bin/bash

cp -r ~/dotfiles ~/.dotfiles

DOTFILES_DIR="$HOME/.dotfiles"
CONFIG_DIR="$HOME/.config"

# neovim
sudo dnf install nvim
ln -sf "$DOTFILES_DIR/nvim" "$CONFIG_DIR/nvim"

# luarocks for image.nvim
sudo dnf install luarocks lua5.1 ImageMagick
luarocks install --lua-version=5.1 --local magick

# shell (zsh + starship for prompt)
curl -sS https://starship.rs/install.sh | sh
ln -sf "$DOTFILES_DIR/starship.toml" "$CONFIG_DIR/starship.toml"
ln -sf "$DOTFILES_DIR/.zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES_DIR/zsh" "$CONFIG_DIR/zsh"

# kitty
sudo dnf install kitty
ln -sf "$DOTFILES_DIR/kitty" "$CONFIG_DIR/kitty"
