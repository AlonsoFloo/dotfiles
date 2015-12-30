#!/bin/bash

DOTFILE_PATH=~/dotfiles/

cd ${DOTFILE_PATH}

#setting links
for file in ${DOTFILE_PATH}{bash_logout,bashrc,bash_profile,zshrc,zlogout,inputrc,gitconfig,vimrc,vim,config}; do
	file="$( basename $file )"
	
	if [[ ! -h ~/.${file} ]] && [[ -d ~/.${file} ]]; then
		cp -rn ~/.${file}/* ${DOTFILE_PATH}${file}/
	fi

	if [[ -h ~/.${file} ]]; then
		rm -f ~/.${file}
	elif [[ -e ~/.${file} ]]; then
		mv ~/.${file} ~/.${file}.dotfiles.bak
	fi
	
	ln -sf ${DOTFILE_PATH}${file} ~/.${file}
done;

#install fonts
chmod +x ${DOTFILE_PATH}powerline-fonts/install.sh
${DOTFILE_PATH}powerline-fonts/install.sh

#set confirguration
${DOTFILE_PATH}set-config.sh

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
