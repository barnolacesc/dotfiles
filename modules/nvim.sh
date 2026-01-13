#!/bin/bash

# Neovim module installer
# This script expects the following to be defined by the parent script:
# - command_exists() function
# - track_component() function
# - PLATFORM variable (macos, ubuntu, or debian)
# - For Linux: run_with_sudo() function

install_nvim_module() {
    echo ""
    echo "Installing Neovim module..."

    # Install neovim
    case $PLATFORM in
        macos)
            if ! brew list neovim &>/dev/null; then
                echo "Installing neovim..."
                if brew install neovim; then
                    echo "✓ neovim installed successfully"
                    track_component "neovim" "✓ installed"
                else
                    echo "❌ Failed to install neovim"
                    track_component "neovim" "❌ failed"
                fi
            else
                echo "✓ neovim is already installed"
                track_component "neovim" "✓ installed"
            fi
            ;;
        ubuntu|debian)
            if ! dpkg -l | grep -q "^ii  neovim "; then
                echo "Installing neovim..."
                if run_with_sudo apt-get install -y neovim; then
                    echo "✓ neovim installed successfully"
                    track_component "neovim" "✓ installed"
                else
                    echo "❌ Failed to install neovim"
                    track_component "neovim" "❌ failed"
                fi
            else
                echo "✓ neovim is already installed"
                track_component "neovim" "✓ installed"
            fi
            ;;
    esac

    # Install lazygit
    case $PLATFORM in
        macos)
            if ! brew list lazygit &>/dev/null; then
                echo "Installing lazygit..."
                if brew install lazygit; then
                    echo "✓ lazygit installed successfully"
                    track_component "lazygit" "✓ installed"
                else
                    echo "⚠️  Failed to install lazygit"
                    track_component "lazygit" "❌ failed"
                fi
            else
                echo "✓ lazygit is already installed"
                track_component "lazygit" "✓ installed"
            fi
            ;;
        ubuntu|debian)
            if ! command_exists lazygit; then
                echo "Installing lazygit..."
                LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
                if [ -n "$LAZYGIT_VERSION" ]; then
                    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
                    if tar xf lazygit.tar.gz lazygit && run_with_sudo install lazygit /usr/local/bin && rm -f lazygit lazygit.tar.gz; then
                        echo "✓ lazygit installed successfully"
                        track_component "lazygit" "✓ installed"
                    else
                        echo "⚠️  Failed to install lazygit"
                        rm -f lazygit lazygit.tar.gz 2>/dev/null
                        track_component "lazygit" "❌ failed"
                    fi
                else
                    echo "⚠️  Failed to fetch lazygit version"
                    track_component "lazygit" "❌ failed"
                fi
            else
                echo "✓ lazygit is already installed"
                track_component "lazygit" "✓ installed"
            fi
            ;;
    esac

    # Clone nvim configuration (shared across all platforms)
    NVIM_CONFIG_DIR="$HOME/.config/nvim"
    if [ ! -d "$NVIM_CONFIG_DIR" ]; then
        echo "Cloning nvim configuration..."
        mkdir -p "$HOME/.config"
        if git clone https://github.com/barnolacesc/nvim "$NVIM_CONFIG_DIR"; then
            echo "✓ nvim configuration cloned successfully"
            track_component "nvim config" "✓ installed"
        else
            echo "❌ Failed to clone nvim configuration"
            track_component "nvim config" "❌ failed"
        fi
    else
        echo "✓ nvim configuration already exists at $NVIM_CONFIG_DIR"
        track_component "nvim config" "✓ exists"
    fi
}
