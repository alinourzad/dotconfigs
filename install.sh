#!/bin/bash
# vim: set noet ts=2 sw=2 ft=sh:

set -e 

print_message () {
	echo ''
	echo $1
	echo ''
}

print_message "INSTALLING REQUIRED PACKAGES"
sudo apt-get install -qq xinit \
	rofi \
	gh git \
	polybar \
	bspwm \
	xfce4-terminal \
	feh \
	network-manager-gnome \
	fonts-firacode \
	qutebrowser \
	vim \
	pulseaudio \
	picom \
	i3lock-fancy \
	python3-pip
print_message "INSTALLING PACKAGES DONE."

create_link(){
	if [[ ! -d ~/.config ]]
	then
		mkdir ~/.config
	fi
	
	cd ~/.config
	ln -s ../dotconfigs/bspwm   . || echo 'bspwm exists'
	ln -s ../dotconfigs/sxhkd   . || echo 'sxhkd already there'
	ln -s ../dotconfigs/polybar . || echo 'polybar already there'
}

if [[ ! -L ~/.config/bspwm ]]
then
	print_message 'CREATING LINKS'
	create_link
	print_message 'CREATING LINGS DONE.'
fi

echo 'exec bspwm' > ~/.xsession

print_message 'DOWNLOADING WALLPAPERS...'
~/dotconfigs/wallhaven.sh > /dev/null
print_message 'DOWNLOADING WALLPAPERS DONE.'

if grep "managed=false" /etc/NetworkManager/NetworkManager.conf > /dev/null
then
	print_message 'CONFIGURING NETWORKMANAGER...'
	sudo sed -i 's/managed=false/managed=true/g' /etc/NetworkManager/NetworkManager.conf
	print_message 'NETWORKMANAGER CONFGURATION DONE.'
fi

if [[ ! -L ~/.vimrc ]]
then
	print_message 'VIMRC'
	cd ~
	ln -s dotconfigs/vimconfigs/vimrc ~/.vimrc
	print_message 'VIMRC DONE.'
fi

