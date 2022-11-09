#!/bin/bash

I3_DOTFILES=(".zshrc" ".gitconfig")
I3_CONFIG_DOTFILES=("i3" "i3status" "kitty" "polybar" "nvim")

function check_internet_connection() {
	ping -c 1 google.com
	  
	if [ "$?" -eq "0" ]
	then
		echo "Confirmed Internet access!"
		echo "Proceeding with configuration..."
	else
		echo "You don't seem to have a stable interet connection"
		echo "Exiting configuration..."
		exit 1
	fi
}

function check_status() {
	# Success message

	if [ "$?" -eq "0" ]
	then
		echo "You are all set!"
		exit 0
	else
		echo "Something seems to be wrong..."
		echo "Exiting Setup..."
		exit 1
	fi
}


function set_up_i3() {
	
	echo "Configuring i3..."

	# Check for existing .config directory
	if [ -d ~/.config/ ]
	then
		echo "Will symlink files to present .config directory"
	else
		echo "making new .config directory..."
		mkdir ~/.config
	fi

	#Symlink files to home directory
	for files in "${I3_DOTFILES[@]}"
	do
		ln -sf ~/dotfiles/Arch/i3-Arch-config/$files ~/
	done

	# Symlink files within .config to home directory
	for files in "${I3_CONFIG_DOTFILES[@]}"
	do
		ln -sf ~/dotfiles/Arch/i3-Arch-config/.config/$files ~/.config/
	done
}


#check_internet_connection
set_up_i3
check_status
