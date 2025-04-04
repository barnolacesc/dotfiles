#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"

# Create necessary directories
mkdir -p ~/.dotfiles

# Create symbolic links
echo "Creating symbolic links for macOS..."

# Link .zshrc
ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc

# Link aliases directory
ln -sf "$DOTFILES_DIR/aliases" ~/.dotfiles/aliases

# macOS-specific configurations
echo "Setting up macOS-specific configurations..."

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install macOS-specific packages
echo "Installing macOS-specific packages..."
brew install zsh
brew install git
brew install wget
brew install curl
brew install htop
brew install tree
brew install ripgrep
brew install fd
brew install fzf
brew install bat
brew install exa

# Install Oh My Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install fzf key bindings
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc

echo "macOS dotfiles installation complete!"
echo "Please restart your terminal or run 'source ~/.zshrc' to apply changes." 