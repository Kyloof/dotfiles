#!/bin/bash

sudo -v
cp -r ~/dotfiles ~/.dotfiles

DOTFILES_DIR="$HOME/.dotfiles"
CONFIG_DIR="$HOME/.config"
FONT_DIR="$HOME/.local/share/fonts"

if [[ $(uname -m) == 'aarch64' ]]; then
    ARCH="aarch64"
else 
    ARCH="x86_64"
fi
 
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
dnf install kitty
ln -sf "$DOTFILES_DIR/kitty" "$CONFIG_DIR/kitty"

# dejavu font
cp -r "$DOTFILES_DIR/dejavu" "$FONT_DIR/dejavu"
kitten --choose-fonts

# typst
wget "https://github.com/typst/typst/releases/download/v0.14.2/typst-$ARCH-unknown-linux-musl.tar.xz" -O- | \
tar -xJ -C /opt/ --strip-components=1 "typst-$ARCH-unkown-linux-musl/typst"

# winogrono-suite
git clone git@github.com:Kyloof/winogrono-suite.git "$HOME/.cache/typst/packages/preview/"


# hyprland

# 
