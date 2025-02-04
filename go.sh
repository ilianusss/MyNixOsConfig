#!/bin/sh

# Define source and destination directories
SOURCE_NVIM="/home/iliane.formet/afs/MyNixOsConfig"
SOURCE_SETUP="/home/iliane.formet/afs/MyNixOsConfig/setup.sh"
DEST_NVIM="$HOME/.config/nvim"
DEST_SETUP="$HOME/.config/setup.sh"

cp "setup.sh" "$DEST_SETUP"
# Check if setup.sh already exists at the destination
#if [ ! -f "$DEST_SETUP" ]; then
#    # If it doesn't exist, copy it
#    echo "not in"
#    rm -f "$DEST_SETUP"
#    cp "$SOURCE_SETUP" "$DEST_SETUP"
#    echo "Copied setup.sh to $DEST_SETUP"
#else
#    cp "$SOURCE_SETUP" "$DEST_SETUP"
#    echo "setup.sh already exists at $DEST_SETUP, but deleted it"
#fi

# Ensure setup.sh is executable
chmod +x "$DEST_SETUP"

# Execute setup.sh
bash "$DEST_SETUP" 

# Create the Neovim configuration directory if it doesn't exist
mkdir -p "$DEST_NVIM"

# Copy all Neovim configuration files from the source to the destination
cp -r "$SOURCE_NVIM"/* "$DEST_NVIM/"

# Remove the compiled packer file to ensure plugins are recompiled
rm -f "$DEST_NVIM/plugin/packer_compiled.lua"
