# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# reading the default bashrc
if [ -r /etc/bashrc ] && [ -f /etc/bashrc ]; then
      . /etc/bashrc
fi

# Init custom Bash
if [ -r ~/dotfiles/bash/init ] && [ -f ~/dotfiles/bash/init ]; then
	source ~/dotfiles/bash/init
fi
