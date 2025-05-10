#!/bin/bash

set -e

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Function to check if a package is installed
package_installed() {
    dpkg -l "$1" &> /dev/null
}

# Function to install a package if not already installed
install_package() {
    local package=$1
    if ! package_installed "$package"; then
        echo "Installing $package..."
        sudo apt install -y "$package"
    else
        echo "$package is already installed, skipping..."
    fi
}

# Create necessary directories
mkdir -p ~/.dotfiles

# Create symbolic links
echo "Creating symbolic links for Ubuntu..."

# Link .zshrc
ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc

# Link aliases directory
ln -sf "$DOTFILES_DIR/aliases" ~/.dotfiles/aliases

# Ubuntu-specific configurations
echo "Setting up Ubuntu-specific configurations..."

# Update package lists
echo "Updating package lists..."
sudo apt update

# Install required packages
echo "Installing required packages..."
install_package zsh
install_package git
install_package curl
install_package wget
install_package htop
install_package tree
install_package ripgrep
install_package fd-find
install_package fzf
install_package bat
install_package eza

# Install Oh My Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh is already installed, skipping..."
fi

# Install required plugins
echo "Installing Zsh plugins..."

ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
AUTO_DIR="$ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions"
HIGHLIGHT_DIR="$ZSH_CUSTOM_DIR/plugins/zsh-syntax-highlighting"

if [ ! -d "$AUTO_DIR" ]; then
    echo "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$AUTO_DIR"
else
    echo "zsh-autosuggestions is already installed, updating..."
    cd "$AUTO_DIR" && git pull && cd - > /dev/null
fi

if [ ! -d "$HIGHLIGHT_DIR" ]; then
    echo "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HIGHLIGHT_DIR"
else
    echo "zsh-syntax-highlighting is already installed, updating..."
    cd "$HIGHLIGHT_DIR" && git pull && cd - > /dev/null
fi

# Install fzf key bindings if fzf is installed
if command_exists fzf; then
    echo "Installing fzf key bindings..."
    if $(which fzf) --install --key-bindings --completion --no-update-rc > /dev/null 2>&1; then
        echo "fzf key bindings installed successfully."
    else
        echo "Warning: fzf key bindings installation encountered an issue."
    fi
else
    echo "Warning: fzf not found, skipping key bindings installation."
fi

# Set zsh as default shell if not already
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Setting zsh as default shell..."
    chsh -s $(which zsh)
else
    echo "zsh is already the default shell, skipping..."
fi

echo -e "\033[1;32m ✓ Ubuntu dotfiles installation complete!\033[0m"
echo "Please restart your terminal or run 'source ~/.zshrc' to apply changes." 