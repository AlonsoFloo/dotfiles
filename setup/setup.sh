#!/bin/bash

DOTFILES_ROOT=~/dotfiles
DOTFILE_PATH=~/dotfiles/dotfiles/

cd ${DOTFILES_ROOT} || exit

#set common confirguration
# shellcheck source=setup/common.sh
source ${DOTFILES_ROOT}/setup/common.sh "$@"


if [[ `uname` == 'Darwin' ]]; then
	#set ios confirguration
# shellcheck source=setup/ios.sh
	source ${DOTFILES_ROOT}/setup/ios.sh
else
	#set linux confirguration
# shellcheck source=setup/linux.sh
	source ${DOTFILES_ROOT}/setup/linux.sh
fi

# Post install configuration
# shellcheck source=setup/common_postinstall.sh
source ${DOTFILES_ROOT}/setup/common_postinstall.sh "$@"

unset file
