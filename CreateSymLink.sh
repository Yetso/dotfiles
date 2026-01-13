#!/usr/bin/env bash

DOTFILES="$HOME/dotfiles"
CONFIG="$HOME/.config"

mkdir -p "$CONFIG"

link () {
    src="$1"
    dest="$2"

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "⚠️  $dest exists, deleting..."
        rm -rf "$dest"
    fi

    ln -s "$src" "$dest"
    echo "✅ $dest → $src"
}

# ~/.config/*
link "$DOTFILES/bat"       "$CONFIG/bat"
link "$DOTFILES/fastfetch" "$CONFIG/fastfetch"
link "$DOTFILES/ghostty"   "$CONFIG/ghostty"
link "$DOTFILES/hyprland"  "$CONFIG/hypr"
link "$DOTFILES/lazygit"   "$CONFIG/lazygit"
link "$DOTFILES/mangohud"  "$CONFIG/MangoHud"
link "$DOTFILES/nvim"      "$CONFIG/nvim"
link "$DOTFILES/starship/starship.toml"  "$CONFIG/starship.toml"
link "$DOTFILES/yazi"      "$CONFIG/yazi"
link "$DOTFILES/zsh/zshrc"  "$HOME/.zshrc"
