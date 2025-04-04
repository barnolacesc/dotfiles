# Dotfiles

Personal dotfiles for managing shell configurations and aliases across different machines.

## Structure

- `.zshrc` - Main Zsh configuration file
- `aliases/` - Directory containing various alias configurations
  - `git.sh` - Git-related aliases
  - `general.sh` - General purpose aliases
- `platforms/` - Platform-specific configurations
  - `macos/` - macOS-specific configurations and installation scripts
  - `ubuntu/` - Ubuntu-specific configurations and installation scripts

## Installation

To use these dotfiles, clone this repository and create symbolic links to the files in your home directory:

```bash
git clone https://github.com/barnolacesc/dotfiles.git
cd dotfiles
./install.sh
```

For platform-specific installation:

```bash
# For macOS
./platforms/macos/install.sh

# For Ubuntu
./platforms/ubuntu/install.sh
```

## Usage

After installation, your shell configurations and aliases will be automatically loaded when you start a new terminal session.

## Maintenance

To add new configurations:
1. Add your new configuration files to the appropriate directory
2. Update the README.md if necessary
3. Commit and push your changes 