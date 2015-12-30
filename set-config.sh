#!/bin/bash

if [[ `uname` == 'Darwin' ]]; then
	if [[ ! "$(which brew)" ]]; then
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi
	#Needed packages
	brew install highlight fortune cowsay > /dev/null

	#Disable the dashboard
	defaults write com.apple.dashboard mcx-disabled -boolean YES
else
	#Needed packages
	if [[ -x /usr/bin/apt-get ]]; then
		sudo apt-get -qq install -y highlight fortune cowsay
	fi
fi