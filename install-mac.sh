#!/bin/bash

rm -rf ~/.dotfiles
cp -rf ~/dotfiles ~/.dotfiles

if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# ===========================
#          Variables
# ===========================
DOTFILES_DIR="$HOME/.dotfiles"
CONFIG_DIR="$HOME/.config"
FONT_DIR="$HOME/Library/Fonts"

mkdir -p "$CONFIG_DIR"

# ===========================
#           Neovim
# ===========================
# 
# Install nvim
brew install nvim
ln -sf "$DOTFILES_DIR/nvim" "$CONFIG_DIR/nvim"

# ===========================
#       ZSH + Starship
# ===========================
brew install starship

ln -sf "$DOTFILES_DIR/starship.toml" "$CONFIG_DIR/starship.toml"
ln -sf "$DOTFILES_DIR/.zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES_DIR/zsh" "$CONFIG_DIR/zsh"

# ===========================
#            Kitty
# ===========================
brew install --cask kitty
ln -sf "$DOTFILES_DIR/kitty" "$CONFIG_DIR/kitty"

# Dejavu font for terminal
cp -rf "$DOTFILES_DIR/dejavu/"* "$FONT_DIR/"

# ===========================
#            Typst
# ===========================
brew install typst

# Template for Typst
TYPST_LOCAL="$HOME/Library/Application Support/typst/packages/local"
mkdir -p "$TYPST_LOCAL"
git clone git@github.com:Kyloof/arkona.git "$TYPST_LOCAL/"



# ===========================
#       Useful Programs
# ===========================
brew install bat rust wget
