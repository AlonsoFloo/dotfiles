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

# Install APM if missing
if ! command -v apm &>/dev/null; then
	echo "Installing APM (Agent Package Manager)..."
	if [[ "$USE_SUDO" == "yes" ]]; then
		curl -fsSL https://aka.ms/apm-unix | sh || true
	else
		echo "Sudo is disabled. Skipping APM installation."
	fi
fi

# Install Android CLI if missing
if ! command -v android &>/dev/null; then
	echo "Installing Android CLI..."
	if [[ "$USE_SUDO" == "yes" ]]; then
		android_os="$(uname -s | tr '[:upper:]' '[:lower:]')"
		android_arch="$(uname -m)"
		[[ "$android_arch" == "aarch64" ]] && android_arch="arm64"
		curl -fsSL "https://dl.google.com/android/cli/latest/${android_os}_${android_arch}/install_root.sh" | bash || true
		unset android_os android_arch
	else
		echo "Sudo is disabled. Skipping Android CLI installation."
	fi
fi

# Install Kotlin Toolchain if missing
if ! command -v kotlin &>/dev/null; then
	echo "Installing Kotlin Toolchain..."
	if [[ "$USE_SUDO" == "yes" ]]; then
		curl -fsSL https://kotl.in/install.sh | sh || true
	else
		echo "Sudo is disabled. Skipping Kotlin Toolchain installation."
	fi
fi
