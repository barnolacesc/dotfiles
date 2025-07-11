#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"

# Initialize counters
REQUIRED_TOTAL=2  # zsh and git
REQUIRED_INSTALLED=0
RECOMMENDED_TOTAL=6  # curl, wget, fzf, bat, ripgrep, fd
RECOMMENDED_INSTALLED=0
OPTIONAL_TOTAL=2  # htop, tree
OPTIONAL_INSTALLED=0
ADDITIONAL_COMPONENTS=()

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Function to install a package if not already installed
install_package() {
    local package=$1
    local required=$2
    local category=$3
    if ! brew list "$package" &>/dev/null; then
        echo "Installing $package..."
        if brew install "$package"; then
            echo "✓ $package installed successfully"
            case $category in
                "required") REQUIRED_INSTALLED=$((REQUIRED_INSTALLED + 1)) ;;
                "recommended") RECOMMENDED_INSTALLED=$((RECOMMENDED_INSTALLED + 1)) ;;
                "optional") OPTIONAL_INSTALLED=$((OPTIONAL_INSTALLED + 1)) ;;
            esac
        else
            if [ "$required" = "true" ]; then
                echo "❌ Failed to install required package: $package"
                echo "Please install it manually and run the script again"
                exit 1
            else
                echo "⚠️  Failed to install optional package: $package"
                echo "Continuing with installation..."
            fi
        fi
    else
        echo "✓ $package is already installed"
        case $category in
            "required") REQUIRED_INSTALLED=$((REQUIRED_INSTALLED + 1)) ;;
            "recommended") RECOMMENDED_INSTALLED=$((RECOMMENDED_INSTALLED + 1)) ;;
            "optional") OPTIONAL_INSTALLED=$((OPTIONAL_INSTALLED + 1)) ;;
        esac
    fi
}

# Function to track additional component status
track_component() {
    local name=$1
    local status=$2
    ADDITIONAL_COMPONENTS+=("$name:$status")
}

# Create necessary directories
mkdir -p ~/.dotfiles

# Create symbolic links
echo "Creating symbolic links for macOS..."

# Link .zshrc
echo "Removing any existing .zshrc..."
rm -f ~/.zshrc
echo "Creating symlink to .zshrc..."
ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc

# Link aliases directory
rm -rf ~/.dotfiles/aliases  # Remove any existing symlink or directory
ln -sf "$DOTFILES_DIR/aliases" ~/.dotfiles/aliases

# Create private aliases file from template if it doesn't exist
if [ ! -f ~/.dotfiles/aliases/private.sh ]; then
    echo "Creating private aliases file from template..."
    cp "$DOTFILES_DIR/aliases/private.sh.template" ~/.dotfiles/aliases/private.sh
    echo "Private aliases file created. Edit ~/.dotfiles/aliases/private.sh to add your personal aliases."
fi

# macOS-specific configurations
echo "Setting up macOS-specific configurations..."

# Check if Homebrew is installed
if ! command_exists brew; then
    echo "Installing Homebrew..."
    if ! /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
        echo "❌ Failed to install Homebrew"
        echo "Please install it manually and run the script again"
        exit 1
    fi
else
    echo "✓ Homebrew is already installed"
    echo "Updating Homebrew..."
    if ! brew update; then
        echo "⚠️  Failed to update Homebrew"
        echo "Continuing with installation..."
    fi
fi

# Install required packages (these are essential)
echo "Installing required packages..."
install_package zsh true "required"
install_package git true "required"

# Install recommended packages (these are nice to have)
echo "Installing recommended packages..."
install_package curl false "recommended"
install_package wget false "recommended"
install_package fzf false "recommended"
install_package bat false "recommended"
install_package ripgrep false "recommended"
install_package fd false "recommended"

# Install optional packages (these can be skipped)
echo "Installing optional packages..."
install_package htop false "optional"
install_package tree false "optional"

# Install Oh My Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    if ! sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended; then
        echo "❌ Failed to install Oh My Zsh"
        echo "Please install it manually and run the script again"
        exit 1
    fi
else
    echo "✓ Oh My Zsh is already installed"
fi

# Install required plugins
echo "Installing Zsh plugins..."

ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
AUTO_DIR="$ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions"
HIGHLIGHT_DIR="$ZSH_CUSTOM_DIR/plugins/zsh-syntax-highlighting"

if [ ! -d "$AUTO_DIR" ]; then
    echo "Installing zsh-autosuggestions..."
    if ! git clone https://github.com/zsh-users/zsh-autosuggestions "$AUTO_DIR"; then
        echo "❌ Failed to install zsh-autosuggestions"
        echo "Please install it manually and run the script again"
        exit 1
    fi
else
    echo "✓ zsh-autosuggestions is already installed"
fi

if [ ! -d "$HIGHLIGHT_DIR" ]; then
    echo "Installing zsh-syntax-highlighting..."
    if ! git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HIGHLIGHT_DIR"; then
        echo "❌ Failed to install zsh-syntax-highlighting"
        echo "Please install it manually and run the script again"
        exit 1
    fi
else
    echo "✓ zsh-syntax-highlighting is already installed"
fi

# Install fzf key bindings if fzf is installed
if command_exists fzf; then
    echo "Installing fzf key bindings..."
    if $(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc > /dev/null 2>&1; then
        echo "✓ fzf key bindings installed successfully"
        track_component "fzf key bindings" "✓ installed"
    else
        echo "⚠️  Failed to install fzf key bindings"
        echo "Continuing with installation..."
        track_component "fzf key bindings" "❌ failed"
    fi
else
    echo "⚠️  fzf not found, skipping key bindings installation"
fi

echo -e "\033[1;32m ✓ macOS dotfiles installation complete!\033[0m"
echo -e "\nInstallation Summary:"
echo -e "Required packages: $REQUIRED_INSTALLED/$REQUIRED_TOTAL installed"
echo -e "Recommended packages: $RECOMMENDED_INSTALLED/$RECOMMENDED_TOTAL installed"
echo -e "Optional packages: $OPTIONAL_INSTALLED/$OPTIONAL_TOTAL installed"
for component in "${ADDITIONAL_COMPONENTS[@]}"; do
    IFS=':' read -r name status <<< "$component"
    echo -e "$name: $status"
done

# Check current shell and provide appropriate instructions
if [ "$SHELL" = "/bin/zsh" ] || [ "$SHELL" = "/usr/bin/zsh" ]; then
    echo -e "\nTo apply the changes, you can either:"
    echo -e "1. Start a new terminal session"
    echo -e "2. Run 'source ~/.zshrc' in your current terminal"
else
    echo -e "\nTo apply the changes:"
    echo -e "1. Start a new terminal session with zsh (run 'zsh')"
    echo -e "2. Or run 'zsh' in your current terminal"
fi 