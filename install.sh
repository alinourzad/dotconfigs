#!/bin/bash
#vim: set noet ts=2 sw=2:

set -e 

sudo apt install -y xinit \
	polybar \
	bspwm \
	xfce4-polybar \
	picom \
	feh \
	network-manager-gnome

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

if [[ ! -L ~/.config/bspwm ]]
then
	create_link
fi

echo 'exec bspwm' > ~/.xsession
