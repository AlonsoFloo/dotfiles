#setting links
for file in ${DOTFILE_PATH}{bash_logout,bashrc,bash_profile,zshrc,zlogout,inputrc,gitconfig,vimrc,vim,config,ssh}; do
	file="$( basename $file )"
	
	if [[ ! -h ~/.${file} ]] && [[ -d ~/.${file} ]]; then
		cp -rn ~/.${file}/* ${DOTFILE_PATH}${file}/
	fi

	if [[ -h ~/.${file} ]]; then
		rm -f ~/.${file}
	elif [[ -e ~/.${file} ]]; then
		mv ~/.${file} ~/.${file}.dotfiles.bak
	fi
	
	ln -sf ${DOTFILE_PATH}${file} ~/.${file}
done;


#install custom zsh theme
ln -s ${DOTFILE_PATH}zsh/theme_powerlevel9k ${DOTFILE_PATH}zsh/oh-my-zsh/custom/themes/powerlevel9k
#install fonts
chmod +x ${DOTFILE_PATH}fonts/powerline/install.sh
${DOTFILE_PATH}fonts/powerline/install.sh
