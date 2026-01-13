#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Parse command line arguments
WITH_NVIM=false

show_help() {
    echo "Usage: ./install.sh [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --with-nvim    Install Neovim with custom configuration"
    echo "  --help         Show this help message"
    echo ""
    echo "Examples:"
    echo "  ./install.sh              # Basic installation"
    echo "  ./install.sh --with-nvim  # Full installation with Neovim"
}

for arg in "$@"; do
    case $arg in
        --with-nvim)
            WITH_NVIM=true
            shift
            ;;
        --help)
            show_help
            exit 0
            ;;
        *)
            echo "Unknown option: $arg"
            show_help
            exit 1
            ;;
    esac
done

export WITH_NVIM

# Detect the operating system
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Detected macOS"
    PLATFORM_SCRIPT="$SCRIPT_DIR/platforms/macos/install.sh"
    chmod +x "$PLATFORM_SCRIPT"
    "$PLATFORM_SCRIPT"
elif [[ -f /etc/os-release ]]; then
    source /etc/os-release
    if [[ "$ID" == "ubuntu" ]]; then
        echo "Detected Ubuntu"
        PLATFORM_SCRIPT="$SCRIPT_DIR/platforms/ubuntu/install.sh"
        chmod +x "$PLATFORM_SCRIPT"
        "$PLATFORM_SCRIPT"
    elif [[ "$ID" == "debian" ]]; then
        echo "Detected Debian"
        PLATFORM_SCRIPT="$SCRIPT_DIR/platforms/debian/install.sh"
        chmod +x "$PLATFORM_SCRIPT"
        "$PLATFORM_SCRIPT"
    else
        echo "Unsupported Linux distribution: $ID"
        exit 1
    fi
else
    echo "Unsupported operating system"
    exit 1
fi 