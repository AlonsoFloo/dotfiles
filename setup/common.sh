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

	if [[ -h ~/."${file}" ]]; then
		rm -f ~/."${file}"
	elif [[ -e ~/."${file}" ]]; then
		mv ~/."${file}" ~/."${file}".dotfiles.bak
	fi

	ln -sf "${DOTFILE_PATH}""${file}" ~/."${file}"
done;

export PATH="$HOME/.local/bin:$HOME/.apm/bin:$PATH"

# Install APM if missing
if ! command -v apm &>/dev/null; then
	echo "Installing APM (Agent Package Manager)..."
	if [[ "$USE_SUDO" == "yes" ]]; then
		curl -fsSL https://aka.ms/apm-unix | sh || true
	else
		mkdir -p "$HOME/.local/bin"
		curl -fsSL https://aka.ms/apm-unix | APM_INSTALL_DIR="$HOME/.local/bin" sh || true
	fi
fi

# Manage local agent skills
if command -v apm &>/dev/null; then
	echo "Managing APM skills in ${DOTFILE_PATH}agents..."
	cd "${DOTFILE_PATH}agents" || exit 1
	if [[ -f "${DOTFILE_PATH}agents/apm.yml" ]]; then
		apm update --yes || apm update || true
	else
		apm install https://github.com/AlonsoFloo/skills#main --target agent-skills || true
	fi
	cd "${DOTFILE_PATH}" || exit 1
fi
