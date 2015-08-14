#!/usr/bin/env bash

cd ~/dotfiles/

exlude_files=".|..|.gitignore|README.md|.git|setup.sh|bash"
for file in `ls -a`
do
	if [[ ! "$i" == "*~" ]]; then
		if [[ ! ${file} =~ ^(${exlude_files})$ ]]; then
			if [[ -h ~/.${file} ]]; then
				rm -f ~/.${file}
			elif [[ -e ~/.${file} ]]; then
				mv ~/.${file} ~/.${file}.dotfiles.bak
			fi
			
			ln -sf ~/dotfiles/${file} ~/.${file} 
		fi
	fi
done
unset file exlude_files
