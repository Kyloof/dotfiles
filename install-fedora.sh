#!/bin/bash

sudo -v
rm -rf ~/.dotfiles
cp -rf ~/dotfiles ~/.dotfiles

# ===========================
#          Variables
# ===========================
DOTFILES_DIR="$HOME/.dotfiles"
CONFIG_DIR="$HOME/.config"
FONT_DIR="/usr/share/fonts"

# CPU architecture
if [[ $(uname -m) == 'aarch64' ]]; then
    ARCH="aarch64"
else
    ARCH="x86_64"
fi


# ===========================
#           Neovim
# ===========================
# 
# Install nvim
sudo dnf install nvim
ln -sf "$DOTFILES_DIR/nvim" "$CONFIG_DIR/nvim"

# Install luarocks - REQUIRED for image.nvim
sudo dnf install luarocks lua5.1 ImageMagick
luarocks install --lua-version=5.1 --local magick


# ===========================
#       ZSH + Starship
# ===========================
sudo dnf install zsh
chsh -s /usr/bin/zsh
curl -sS https://starship.rs/install.sh | sh

ln -sf "$DOTFILES_DIR/starship.toml" "$CONFIG_DIR/starship.toml"
ln -sf "$DOTFILES_DIR/.zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES_DIR/zsh" "$CONFIG_DIR/zsh"

# ===========================
#            Kitty
# ===========================
sudo dnf install kitty
ln -sf "$DOTFILES_DIR/kitty" "$CONFIG_DIR/kitty"

# Dejavu font (my font of choice for terminal work)
sudo cp -rf "$DOTFILES_DIR/dejavu" "$FONT_DIR/dejavu"
sudo fc-cache -fv

# Select the font via a kitten menu
kitty -e kitten choose-fonts

# ===========================
#            Typst
# ===========================
wget -nv "https://github.com/typst/typst/releases/download/v0.14.2/typst-$ARCH-unknown-linux-musl.tar.xz" -O- | \
sudo tar -xJ -C /opt/ --strip-components=1 "typst-$ARCH-unknown-linux-musl/typst"
sudo ln -sf /opt/typst /usr/bin/typst

# Custom fork of grape-suite theme - winogrono-suite
mkdir -p "$HOME/.local/share/typst/packages/local"
git clone git@github.com:Kyloof/winogrono-suite.git "$HOME/.local/share/typst/packages/local/winogrono-suite"



# ===========================
#       Useful Programs
# ===========================
sudo dnf install bat cargo
