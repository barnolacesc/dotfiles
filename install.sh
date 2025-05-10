#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Detect the operating system
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Detected macOS"
    "$SCRIPT_DIR/platforms/macos/install.sh"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Check if it's Ubuntu
    if [ -f /etc/lsb-release ]; then
        echo "Detected Ubuntu"
        "$SCRIPT_DIR/platforms/ubuntu/install.sh"
    else
        echo "Unsupported Linux distribution. Please use a platform-specific installation script."
        exit 1
    fi
else
    echo "Unsupported operating system: $OSTYPE"
    echo "Please use a platform-specific installation script."
    exit 1
fi 