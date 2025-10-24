#!/bin/bash

DOTFILE_PATH=~/dotfiles/

cd "${DOTFILE_PATH}" || exit

#set common confirguration
# shellcheck source=setup/common.sh
source ./setup/common.sh


if [[ "$(uname)" == 'Darwin' ]]; then
	#set ios confirguration
	# shellcheck source=setup/ios.sh
	source ./setup/ios.sh
else
	#set linux confirguration
	# shellcheck source=setup/linux.sh
	source ./setup/linux.sh
fi

#install ZSH
if [[ "$#" -ne 1 ]] && [[ "$1" != "--quiet" ]]; then
	user_value=""
	echo "Do you want to install ZSH Shell ? (yes/no) "
	read -r user_value
	if [[ "$user_value" == "yes" ]]; then
		if [[ -x /usr/bin/apt-get ]]; then
			sudo apt-get install -y zsh
		else
			brew install zsh coreutils
		fi
	fi
fi

unset file