#!/bin/bash

# This script performs system updates, clones a Git repository,
# and installs Node.js along with npm, then displays their versions.

# Ensuring the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root." 1>&2
    exit 1
fi

# Update package lists
echo "Updating package lists..."
sudo apt-get update

# Clone the Git repository
echo "Cloning the solana-trading-bot repository..."
git clone https://github.com/invisiblestrangler/solana-trading-bot

# Install Node.js
echo "Installing Node.js..."
sudo apt install -y nodejs

# Display the version of Node.js
echo "The installed version of Node.js is:"
node -v

# Install npm
echo "Installing npm..."
sudo apt install -y npm

# Display the version of npm
echo "The installed version of npm is:"
npm -v

echo "Setup completed successfully."
