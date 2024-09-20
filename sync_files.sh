#!/bin/zsh

# Define the directories
local_dir="./play.pokemonshowdown.com/js/"
remote_url="https://play.pokemonshowdown.com/js"

# Create a temporary directory to store the downloaded files
temp_dir=$(mktemp -d)

# Download the remote files using wget
echo "Downloading files from $remote_url..."
wget -r -np -nH --cut-dirs=1 -P "$temp_dir" "$remote_url"

# Check if wget was successful
if [[ $? -eq 0 ]]; then
    echo "Download completed successfully."

    # Sync the downloaded files with the local directory
    echo "Syncing files to $local_dir..."
    rsync -av --delete "$temp_dir/" "$local_dir/"
    
    # Clean up temporary directory
    rm -rf "$temp_dir"
    echo "Update completed and temporary files removed."
else
    echo "Error downloading files. Please check the URL or your connection."
fi
