#!/bin/bash

DOTFILE_PATH=~/dotfiles/

cd ${DOTFILE_PATH}

#set common confirguration
source ${DOTFILE_PATH}setup/common.sh


if [[ `uname` == 'Darwin' ]]; then
	#set ios confirguration
	source ${DOTFILE_PATH}setup/ios.sh
else
	#set linux confirguration
	source ${DOTFILE_PATH}setup/linux.sh
fi

#install ZSH
if [[ "$#" -ne 1 ]] && [[ "$1" != "--quiet" ]]; then
	user_value=""
	echo "Do you want to install ZSH Shell ? (yes/no) "
	read user_value
	if [[ "$user_value" == "yes" ]]; then
		if [[ -x /usr/bin/apt-get ]]; then
			sudo apt-get install -y zsh
		else
			brew install zsh zsh-completions coreutils
		fi
	fi
fi

unset file

##Package to download
#google-chrome
#google-drive
#iterm2 (mac)
#ImageOptim (mac)
#Cyberduck (mac)
#SiweUp (mac)
#AMPPS

##Personal use
#Keepass Desktop (mac)
#vlc
#teamviewer
#steam
#origin (Windows)
#skype
#teamspeak-client
#razer synapse

##From App Store
#xCode
#textwrangler
#Caffeine
