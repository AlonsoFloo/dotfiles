#!/bin/bash

cd ~/dotfiles/

for file in ~/dotfiles/{bash_logout,bashrc,bash_profile,zshrc,zlogout,inputrc,gitconfig,config}; do
	file="$( basename $file )"
	
	if [[ -d ~/.${file} ]]; then
		cp -rn ~/.${file}/* ~/dotfiles/${file}/
	fi

	if [[ -h ~/.${file} ]]; then
		rm -f ~/.${file}
	elif [[ -e ~/.${file} ]]; then
		mv ~/.${file} ~/.${file}.dotfiles.bak
	fi
	
	ln -sf ~/dotfiles/${file} ~/.${file}
done;


chmod +x ~/dotfiles/powerline-fonts/install.sh
~/dotfiles/powerline-fonts/install.sh	

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
