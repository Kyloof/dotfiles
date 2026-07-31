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
ln -snf "$DOTFILES_DIR/nvim" "$CONFIG_DIR/nvim"

# Install luarocks - REQUIRED for image.nvim
sudo dnf install luarocks lua5.1 ImageMagick
luarocks install --lua-version=5.1 --local magick


# ===========================
#       ZSH + Starship
# ===========================
sudo dnf install zsh
chsh -s /usr/bin/zsh
curl -sS https://starship.rs/install.sh | sh

ln -snf "$DOTFILES_DIR/starship.toml" "$CONFIG_DIR/starship.toml"
ln -snf "$DOTFILES_DIR/.zshenv" "$HOME/.zshenv"
ln -snf "$DOTFILES_DIR/zsh" "$CONFIG_DIR/zsh"

# ===========================
#            Sway
# ===========================
ln -snf "$DOTFILES_DIR/sway" "$CONFIG_DIR/sway"

# swaylock-fancy
git clone https://github.com/Big-B/swaylock-fancy "$HOME/swaylock-fancy"
sudo make install "$HOME/swaylock-fancy"
rm -rf "$HOME/swaylock-fancy"

# papirus icon theme
wget -qO- https://git.io/papirus-icon-theme-install | sh

# ===========================
#           Waybar
# ===========================

ln -snf "$DOTFILES_DIR/waybar" "$CONFIG_DIR/waybar"




# ===========================
#            Kitty
# ===========================
sudo dnf install kitty
ln -snf "$DOTFILES_DIR/kitty" "$CONFIG_DIR/kitty"

# Dejavu font (my font of choice for terminal work)
sudo cp -rf "$DOTFILES_DIR/hack-nerd-font" "$FONT_DIR/hack-nerd-font"
sudo fc-cache -fv


# ===========================
#            Typst
# ===========================
wget -nv "https://github.com/typst/typst/releases/download/v0.14.2/typst-$ARCH-unknown-linux-musl.tar.xz" -O- | \
sudo tar -xJ -C /opt/ --strip-components=1 "typst-$ARCH-unknown-linux-musl/typst"
sudo ln -snf /opt/typst /usr/bin/typst

# Custom fork of grape-suite theme - arkona
mkdir -p "$HOME/.local/share/typst/packages/local"
git clone git@github.com:Kyloof/arkona.git "$HOME/.local/share/typst/packages/local/arkona"



# ===========================
#       Useful Programs
# ===========================
sudo dnf install bat cargo
