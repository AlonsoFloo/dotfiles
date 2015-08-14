#!/bin/bash

cd ~/dotfiles/

for file in ~/dotfiles/{bash_logout,bash_profile,bashrc,gitconfig,profile,config}; do
	file="$( basename $file )"
	if [[ -h ~/.${file} ]]; then
		rm -f ~/.${file}
	elif [[ -e ~/.${file} ]]; then
		mv ~/.${file} ~/.${file}.dotfiles.bak
	fi

	ln -sf ~/dotfiles/${file} ~/.${file}
done;

unset file
