# Using BASH
if [ -n "$BASH_VERSION" ]; then
	if [ -r ~/.bashrc ] && [ -f ~/.bashrc ]; then
		source ~/.bashrc
	fi
fi
