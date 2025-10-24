#!/bin/bash

# ------------------------------------------------------------------------------
# | macOS Setup Script
# ------------------------------------------------------------------------------
#
# This script automates the setup of a new macOS machine for development. It
# installs Homebrew and essential packages.
#

# ---
# | Helper Functions
# ---

# Output a message to the console.
#
# $1: The message to output.
# $2: The color of the message (optional).
function message() {
  local color="\x1B[0m" # Default to no color.

  if [ -n "$2" ]; then
    case "$2" in
      "red") color="\x1B[31m" ;;
      "green") color="\x1B[32m" ;;
      "yellow") color="\x1B[33m" ;;
      "blue") color="\x1B[34m" ;;
    esac
  fi

  echo -e "${color}${1}\x1B[0m"
}

# ---
# | Homebrew Installation
# ---

# Check if Homebrew is installed and install it if it's not.
if ! command -v brew &> /dev/null; then
  message "Homebrew not found. Installing..." "yellow"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  message "Homebrew installed successfully." "green"
else
  message "Homebrew is already installed." "green"
fi

# Install packages
brew install ruby
brew install swiftlint
brew install curl
brew install highlight
brew install git-ftp

# ---
# | macOS Configuration
# ---

# Run the macOS configuration script.
message "Configuring macOS with sensible defaults..." "blue"
if [ -z "$DOTFILE_PATH" ]; then
  DOTFILE_PATH=~/dotfiles/
fi
source "${DOTFILE_PATH}setup/macos.sh"
message "macOS configuration complete." "green"
