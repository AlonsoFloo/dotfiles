#!/bin/bash

export DOTFILES_REPO=~/dotfiles
export DOTFILE_PATH=~/dotfiles/src/

cd ${DOTFILES_REPO} || exit

# Fetch submodules (oh-my-zsh, zsh-syntax-highlighting, dircolors) when the repo
# was cloned without --recursive, e.g. by VS Code dev containers "dotfiles.repository".
git submodule update --init --recursive || echo "Unable to fetch git submodules, zsh plugins may be missing"

#set common confirguration
# shellcheck source=setup/common.sh
source ${DOTFILES_REPO}/setup/common.sh "$@"


if [[ `uname` == 'Darwin' ]]; then
	#set ios confirguration
# shellcheck source=setup/ios.sh
	source ${DOTFILES_REPO}/setup/ios.sh
else
	#set linux confirguration
# shellcheck source=setup/linux.sh
	source ${DOTFILES_REPO}/setup/linux.sh
fi

# Post install configuration
# shellcheck source=setup/common_postinstall.sh
source ${DOTFILES_REPO}/setup/common_postinstall.sh "$@"

# A fresh setup is up to date: do not ask to update on the first shell
echo "$(($(date +%s) / 60 / 60 / 24))" > ~/.dotfiles-update

unset file
