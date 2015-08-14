# Using BASH
if [ $SHELL == "/bin/bash" ]; then
	if [ -r ~/.bashrc ] && [ -f ~/.bashrc ]; then
		source ~/.bashrc
	fi
fi
