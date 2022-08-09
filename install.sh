#!/bin/bash
#vim: set noet ts=2 sw=2:

set -e 

sudo apt install -y xinit \
	rofi \
	gh git \
	polybar \
	bspwm \
	xfce4-terminal \
	picom \
	feh \
	network-manager-gnome \
	fonts-firacode \
	qutebrowser \
	vim 

clone_repository () {
	cd ~
	git clone https://github.com/alinourzad/dotconfigs 
}

create_link(){
	if [ -! -d ~/.config ]; 
	then
		mkdir ~/.config
	fi
	
	cd ~/.config
	ln -s ../dotconfigs/bspwm .
	ln -s ../dotconfigs/sxhkd .
	ln -s ../dotconfigs/polybar .
}

if [[ ! -d ~/dotconfigs ]]
then
	echo 'CLONING REPOSITORY' clone_repository 
elif [[ -d ~/dotconfigs ]] 
then
	echo 'PULLING REPOSITORY'
	cd ~/dotconfigs
	git pull
	cd ~
fi

if [[ ! -L ~/.config/bspwm ]]
then
	echo 'CREATING LINKS'
	create_link
fi

echo 'exec bspwm' > ~/.xsession

echo 'DOWNLOADING WALLPAPERS'
~/dotconfigs/wallhaven.sh
