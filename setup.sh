#!/bin/bash

DOTFILE_PATH=~/dotfiles/

cd ${DOTFILE_PATH} || exit

#set common confirguration
# shellcheck source=setup/common.sh
source ${DOTFILE_PATH}setup/common.sh "$@"


if [[ `uname` == 'Darwin' ]]; then
	#set ios confirguration
# shellcheck source=setup/ios.sh
	source ${DOTFILE_PATH}setup/ios.sh
else
	#set linux confirguration
# shellcheck source=setup/linux.sh
	source ${DOTFILE_PATH}setup/linux.sh
fi

unset file
