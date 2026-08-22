#!/bin/bash

export DOTFILES_REPO=~/dotfiles
export DOTFILE_PATH=~/dotfiles/src/

cd ${DOTFILES_REPO} || exit

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

unset file
