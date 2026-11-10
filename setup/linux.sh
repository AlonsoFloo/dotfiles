#!/bin/bash
#Needed packages
if [[ -x /usr/bin/apt-get ]]; then
	execute_with_sudo apt-get -qq install -y highlight
fi
