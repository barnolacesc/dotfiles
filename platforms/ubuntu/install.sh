#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"

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
sudo apt install -y zsh git curl wget htop tree ripgrep fd-find fzf bat exa

# Install Oh My Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install fzf key bindings
$(which fzf) --install --key-bindings --completion --no-update-rc

# Set zsh as default shell if not already
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Setting zsh as default shell..."
    chsh -s $(which zsh)
fi

echo "Ubuntu dotfiles installation complete!"
echo "Please restart your terminal or run 'source ~/.zshrc' to apply changes." 