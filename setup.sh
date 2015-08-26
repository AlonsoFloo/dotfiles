#!/bin/bash

DOTFILE_PATH=~/dotfiles/

cd ${DOTFILE_PATH}

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


chmod +x ${DOTFILE_PATH}powerline-fonts/install.sh
${DOTFILE_PATH}powerline-fonts/install.sh	

unset file

#Needed packages
if [[ -x /usr/bin/apt-get ]]; then
	sudo apt-get -qq install -y highlight
elif [[ "$(which brew)" ]]; then
	brew install highlight > /dev/null
fi

if [[ "$#" -ne 1 ]] && [[ "$1" != "--quiet" ]]; then
	user_value=""
	echo "Do you want to install ZSH Shell ? (yes/no) "
	read user_value
	if [[ "$user_value" == "yes" ]]; then
		if [[ -x /usr/bin/apt-get ]]; then
			sudo apt-get install -y zsh
		else
			if [[ ! "$(which brew)" ]]; then
				ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
			fi
			brew install zsh zsh-completions
		fi
	fi
fi
