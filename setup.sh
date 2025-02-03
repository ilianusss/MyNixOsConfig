#!/usr/bin/env bash
set -euo pipefail

# Log file for setup script
LOGFILE="$HOME/setup.log"
exec > >(tee -a "$LOGFILE") 2>&1

echo "Starting setup at $(date)"

# Function to install a package using nix profile install
install_package() {
    local package_name=$1
    local command_name=$2
    if ! command -v "$command_name" &> /dev/null; then
        echo "$command_name is not installed. Installing $package_name..."
        nix profile install nixpkgs#"$package_name"
        echo "$command_name is installed."
    else
        echo "$command_name is already installed."
    fi
}

# Install necessary packages: Kitty, Neovim, wget, fontconfig, PT Mono font, and rofi
install_package "kitty" "kitty"
install_package "neovim" "nvim"
install_package "wget" "wget"
install_package "fontconfig" "fc-cache"
install_package "fonts.pt-mono" "fc-list"
install_package "rofi" "rofi"

# Function to install yazi using Nix
install_yazi() {
    if ! command -v yazi &> /dev/null; then
        echo "Installing yazi from Nix profile..."
        nix profile install github:sxyazi/yazi
        echo "Yazi installed successfully."
    else
        echo "Yazi is already installed."
    fi
}

# Set up Kitty configuration
setup_kitty_config() {
    KITTY_CONFIG_DIR="$HOME/.config/kitty"
    mkdir -p "$KITTY_CONFIG_DIR"

    # Write current-theme.conf
    cat > "$KITTY_CONFIG_DIR/current-theme.conf" << 'EOF'
## name: Gruvbox Dark Soft
## author: Pavel Pertsev
## license: MIT/X11
## upstream: https://raw.githubusercontent.com/gruvbox-community/gruvbox-contrib/master/kitty/gruvbox-dark-soft.conf

selection_foreground    #ebdbb2
selection_background    #d65d0e

background              #32302f
foreground              #ebdbb2

color0                  #3c3836
color1                  #cc241d
color2                  #98971a
color3                  #d79921
color4                  #458588
color5                  #b16286
color6                  #689d6a
color7                  #a89984
color8                  #928374
color9                  #fb4934
color10                 #b8bb26
color11                 #fabd2f
color12                 #83a598
color13                 #d3869b
color14                 #8ec07c
color15                 #fbf1c7

cursor                  #bdae93
cursor_text_color       #665c54

url_color               #458588
EOF

    # Write kitty.conf
    cat > "$KITTY_CONFIG_DIR/kitty.conf" << 'EOF'
# BEGIN_KITTY_THEME
# Gruvbox Dark Soft
include current-theme.conf
# END_KITTY_THEME

# BEGIN_KITTY_FONTS
font_family      PT Mono
bold_font        auto
italic_font      auto
bold_italic_font auto
font_size 15.0
# END_KITTY_FONTS

# Additional configurations can be added here
EOF

    echo "Kitty configuration files have been set up."
}

# Set up Neovim configuration
setup_neovim_config() {
    # Determine the script's directory
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    NVIM_SOURCE_DIR="$SCRIPT_DIR/nvim"
    NVIM_TARGET_DIR="$HOME/.config/nvim"

    # Check if source nvim directory exists
    if [ ! -d "$NVIM_SOURCE_DIR" ]; then
        echo "Neovim source configuration directory ($NVIM_SOURCE_DIR) does not exist."
        echo "Please ensure your Neovim configuration is located in the 'nvim' subdirectory."
        exit 1
    fi

    # Create target directory
    mkdir -p "$NVIM_TARGET_DIR"

    # Copy Neovim configuration
    rsync -av --delete "$NVIM_SOURCE_DIR/" "$NVIM_TARGET_DIR/"

    echo "Neovim configuration has been set up."
}

# Install Neovim plugins
install_neovim_plugins() {
    echo "Installing Neovim plugins..."
    nvim --headless +PackerSync +qa
    echo "Neovim plugins installed."
}

# Execute setup functions
setup_kitty_config
setup_neovim_config
# IL FAIT DES BETISES
#install_yazi
install_neovim_plugins

echo "All configurations have been set up successfully at $(date)."
