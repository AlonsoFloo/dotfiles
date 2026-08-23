#!/bin/bash

# Sudo check
if [[ -z "$USE_SUDO_PROMPTED" ]]; then
	export USE_SUDO="no"
	if [[ "$1" != "--quiet" ]]; then
		echo "Do you want to use sudo for installation? (Y/n) "
		read -r user_sudo
		if [[ -z "$user_sudo" ]] || [[ "$user_sudo" =~ ^[Yy](es)?$ ]]; then
			export USE_SUDO="yes"
		fi
	fi
	export USE_SUDO_PROMPTED="yes"
fi

execute_with_sudo() {
	if [[ "$USE_SUDO" == "yes" ]]; then
		sudo "$@"
	else
		echo "Skipping command requiring sudo: $*"
	fi
}

#setting links
for file in "${DOTFILE_PATH}"{bash_logout,bashrc,bash_profile,zshrc,zlogout,inputrc,gitconfig,vimrc,vim,config,ssh,agents}; do
	file="$( basename "$file" )"

	if [[ ! -h ~/."${file}" ]] && [[ -d ~/."${file}" ]]; then
		cp -rn ~/."${file}"/* "${DOTFILE_PATH}""${file}"/
	fi

	if [[ -e ~/."${file}" ]] || [[ -h ~/."${file}" ]]; then
		rm -rf ~/."${file}".dotfiles.bak
		cp -rL ~/."${file}" ~/."${file}".dotfiles.bak
		rm -rf ~/."${file}"
	fi

	ln -sf "${DOTFILE_PATH}""${file}" ~/."${file}"
done;
