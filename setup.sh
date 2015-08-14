#!/bin/bash

cd ~/dotfiles/

for file in ~/dotfiles/{bash_logout,bashrc,zshrc,zlogout,gitconfig,config}; do
	file="$( basename $file )"
	if [[ -h ~/.${file} ]]; then
		rm -f ~/.${file}
	elif [[ -e ~/.${file} ]]; then
		mv ~/.${file} ~/.${file}.dotfiles.bak
	fi

	ln -sf ~/dotfiles/${file} ~/.${file}
done;

unset file

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
