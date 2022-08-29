#!/bin/bash

set -e 

office () {
	xrandr --output eDP-1 --mode 1920x1080 --primary \
		--output DVI-I-1-1 --mode 1920x1200 --above eDP-1 \
		--output DVI-I-2-2 --mode 1920x1200 --right-of DVI-I-1-1
	
	bspc monitor DVI-I-1-1 -g 1920x1200+0+0
	bspc monitor DVI-I-1-1 -d 1 4

	bspc monitor DVI-I-2-2 -g 1920x1200+1920+0
	bspc monitor DVI-I-2-2 -d 2 5

	bspc monitor eDP-1 -g 1920x1080+0+1200
	bspc monitor eDP-1 -d 3 6
	
	polybar dvi1 &>/dev/null & disown
	polybar dvi2 &>/dev/null & disown
}

home () {
	xrandr --output eDP-1 --mode 1920x1080 --primary
	
	bspc monitor eDP-1 -g 1920x1080+0+0
	bspc monitor eDP-1 -d 1 2 3 4
}

config2 () {
	xrandr --listmonitors | grep DVI-I-1-1 && 
	office || home 
}

[ $1 = 'config' ] &&  config2


