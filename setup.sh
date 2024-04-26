#!/bin/bash

# This script performs system updates, clones a Git repository,
# installs Node.js, nvm, and npm, then sets up the trading bot.

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

echo "Updating package lists..."
sudo apt-get update

echo "Cloning the solana-trading-bot repository..."
git clone https://github.com/invisiblestrangler/solana-trading-bot

# Navigate into the cloned repository directory
cd solana-trading-bot

# Install Node.js if not installed
if ! command -v node > /dev/null 2>&1; then
    echo "Installing Node.js..."
    sudo apt-get install -y nodejs
    echo "The installed version of Node.js is:"
    node -v
fi

# Install npm if not installed
if ! command -v npm > /dev/null 2>&1; then
    echo "Installing npm..."
    sudo apt-get install -y npm
    echo "The installed version of npm is:"
    npm -v
fi

echo "Installing nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Set up environment variables for nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

echo "Installing and using the latest LTS version of Node.js..."
nvm install --lts
nvm use --lts

echo "Installing npm packages required by the trading bot..."
npm install
npm i @metaplex-foundation/umi-serializers

echo "Setup completed successfully."
