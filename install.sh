#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create necessary directories
mkdir -p ~/.dotfiles

# Create symbolic links
echo "Creating symbolic links..."

# Link .zshrc
ln -sf "$SCRIPT_DIR/.zshrc" ~/.zshrc

# Link aliases directory
ln -sf "$SCRIPT_DIR/aliases" ~/.dotfiles/aliases

echo "Dotfiles installation complete!"
echo "Please restart your terminal or run 'source ~/.zshrc' to apply changes." 