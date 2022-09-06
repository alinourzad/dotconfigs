#!/bin/bash
# vim: set noet ts=2 sw=2 ft=sh:

set -e 

print_message () {
	echo ''
	echo $1
	echo ''
}

print_message "INSTALLING REQUIRED PACKAGES"

install_picom() {
    sudo apt-get install -qq libxext-dev libxcb1-dev \
	 libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev \
	 libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev \
	 libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev \
	 libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev \
	 libdbus-1-dev libconfig-dev libgl1-mesa-dev \
	 libpcre2-dev libevdev-dev uthash-dev \
	 libev-dev libx11-xcb-dev \
	 libpcre3-dev
    [[ -d picom ]] && rm -rf picom
    pushd .
    gh repo clone jonaburg/picom
    cd picom
    git submodule update --init --recursive
    meson --buildtype=release . build
    ninja -C build
    ninja -C build install
    popd
    rm -rf picom
}

sudo apt-get install -qq xinit \
     meson ninja-build \
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
	i3lock-fancy \
	dunst \
	nnn \
	brightnessctl \
	python3-pip

which picom > /dev/null || install_picom

print_message "INSTALLING PACKAGES DONE."

create_link(){
	[[ ! -d ~/.config ]] && mkdir .config
	
	ln -s $PWD/bspwm   ~/.config || echo 'bspwm exists'
	ln -s $PWD/sxhkd   ~/.config || echo 'sxhkd already there'
	ln -s $PWD/polybar ~/.config || echo 'polybar already there'
	ln -s $PWD/picom   ~/.config || echo 'picom already exists'

	[[ ! -d ~/.local/bin ]] && mkdir ~/.local/bin
	ln -s $PWD/scripts/pavolume.sh ~/.local/bin/pavolume.sh || echo 'pavolume.sh exists'
}

create_link

echo 'exec bspwm' > ~/.xsession

print_message 'DOWNLOADING WALLPAPERS...'
$PWD/wallhaven.sh > /dev/null
print_message 'DOWNLOADING WALLPAPERS DONE.'

if grep "managed=false" /etc/NetworkManager/NetworkManager.conf > /dev/null
then
	print_message 'CONFIGURING NETWORKMANAGER...'
	sudo sed -i 's/managed=false/managed=true/g' /etc/NetworkManager/NetworkManager.conf
	print_message 'NETWORKMANAGER CONFGURATION DONE.'
fi

if [[ ! -L ~/.vimrc ]] && [[ ! -f ~/.vimrc ]] 
then
	print_message 'VIMRC'
	ln -s $PWD/vimconfigs/vimrc ~/.vimrc
	print_message 'VIMRC DONE.'
fi

# HANDLING DUNST CONFIGURATION
if [[ ! -L ~/.config/dunst ]];
then
	ln -s $PWD/dunst ~/.config/dunst
fi
