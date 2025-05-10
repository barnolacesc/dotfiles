# Dotfiles

Personal dotfiles for managing shell configurations and aliases across different machines. This repository contains a comprehensive Zsh setup with Oh My Zsh, useful aliases, and platform-specific configurations.

## Features

- **Enhanced Zsh Configuration**
  - Custom prompt showing username, hostname, SSH status, and git information
  - Syntax highlighting and autosuggestions
  - Comprehensive history and completion settings

- **Custom Prompt**
  ```
  [SSH] username@hostname ~/current/directory git:(branch) ✗ $
  ```
  - SSH indicator appears when connected via SSH
  - Username and hostname in cyan
  - Current directory in yellow
  - Git branch and status from robbyrussell theme
  - Dirty status indicator (✗) when repo has uncommitted changes

- **Useful Aliases**
  - Git shortcuts (20 most common commands)
  - Docker compose shortcuts
  - System management aliases
  - Directory navigation shortcuts

- **Platform Support**
  - macOS configuration with Homebrew
  - Ubuntu configuration with apt
  - Debian configuration with apt
  - Automatic platform detection and setup

## Prerequisites

- Git
- Zsh
- Curl or Wget

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/barnolacesc/dotfiles.git
   cd dotfiles
   ```

2. Run the installation script:
   ```bash
   ./install.sh
   ```

The script will automatically detect your operating system and run the appropriate platform-specific installation. It will:
- Install required packages
- Set up Oh My Zsh
- Configure Zsh as your default shell
- Create necessary symbolic links
- Install additional plugins

## Plugin Installation

The configuration uses two additional plugins that are automatically installed by the installation script:
- Zsh Autosuggestions
- Zsh Syntax Highlighting

You don't need to install these manually anymore.

## Usage

After installation, you'll have access to:

### Git Aliases
- `g` - Basic git command
- `ga` - Add files to staging
- `gco` - Checkout branch
- `gc` - Commit with verbose output
- `gp` - Push to remote
- And 15 more common Git commands

### Docker Shortcuts
- `dc` - Docker compose command

### System Management
- `status` - Check service status
- `start` - Start a service
- `stop` - Stop a service
- `restart` - Restart a service
- `enable` - Enable a service
- `disable` - Disable a service

### System Aliases
- `cls` - Clear screen
- `ll` - List files with details
- `la` - List all files
- `l` - List files in compact format

## Customization

To add your own configurations:

1. Add new aliases in the `aliases/` directory
2. Modify `.zshrc` for shell configuration changes
3. Update platform-specific scripts in `platforms/` if needed

## Maintenance

To update your dotfiles:
1. Pull the latest changes:
   ```bash
   cd ~/.dotfiles
   git pull
   ```
2. Run the installation script again to apply any new changes

## Contributing

Feel free to fork this repository and customize it for your own use. If you find any bugs or have suggestions for improvements, please open an issue or submit a pull request. 