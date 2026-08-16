#!/bin/bash
#Needed packages
if [[ -x /usr/bin/apt-get ]]; then
	execute_with_sudo apt-get -qq install -y highlight
fi

# Install APM if missing
if ! command -v apm &>/dev/null; then
	echo "Installing APM (Agent Package Manager)..."
	if [[ "$USE_SUDO" == "yes" ]]; then
		curl -fsSL https://aka.ms/apm-unix | sh || true
	else
		echo "Sudo is disabled. Skipping APM installation."
	fi
fi
