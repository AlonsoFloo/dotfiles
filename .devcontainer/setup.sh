#!/bin/bash
set -e

# The Microsoft base image comes with a non-root 'vscode' user with passwordless sudo.
# This script runs as that user.

# 1. Update package lists and install system dependencies
sudo apt-get update
sudo apt-get install -y python3-pip

# 2. Install Node.js using nvm (Node Version Manager)
# This is the recommended way to install Node.js in the devcontainer images.
export NVM_DIR="$HOME/.nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts
nvm use --lts

# 3. Install user-specific Python and Node.js packages
pip install --user pre-commit
npm install -g @google/gemini-cli

# 4. Add pip's user-level bin directory to the PATH for the current and future sessions.
export PATH="$HOME/.local/bin:$PATH"
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

# 5. Install pre-commit hooks
pre-commit install --install-hooks

echo "Devcontainer setup complete!"
