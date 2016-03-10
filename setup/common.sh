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

#install fonts
chmod +x ${DOTFILE_PATH}powerline-fonts/install.sh
${DOTFILE_PATH}powerline-fonts/install.sh
