#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Detect the operating system
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Detected macOS"
    "$SCRIPT_DIR/platforms/macos/install.sh"
elif [[ -f /etc/os-release ]]; then
    source /etc/os-release
    if [[ "$ID" == "ubuntu" ]]; then
        echo "Detected Ubuntu"
        "$SCRIPT_DIR/platforms/ubuntu/install.sh"
    elif [[ "$ID" == "debian" ]]; then
        echo "Detected Debian"
        "$SCRIPT_DIR/platforms/debian/install.sh"
    else
        echo "Unsupported Linux distribution: $ID"
        exit 1
    fi
else
    echo "Unsupported operating system"
    exit 1
fi 