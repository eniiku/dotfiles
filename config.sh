#!/bin/bash

# Debian-Based Distros

GLOBAL_PACKAGES=("nodejs" "neovim" "code" "kitty" "default-jdk" "python3-pip" "neofetch")
REQUIRED_NODE_PACKAGES=("yarn")

DEBIAN_DOTFILES=(".bashrc" ".gitconfig")
DEBIAN_CONFIG_DOTFILES=("nvim" "kitty" "neofetch")

ARCH_DOTFILES=(".xinitrc" ".screenlayout" ".zshrc" ".zprofile" ".bash_profile" ".gitconfig")
ARCH_CONFIG_DOTFILES=("bspwm" "sxhkd" "nvim" "polybar" "ranger" "redshift" "dunst" "kitty" "neofetch" "rofi")
ARCH_LOCAL_DOTFILES=("bin")

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


check_internet_connection

# Determine Current Distro

if [ -e /bin/apt ]
then
	echo "Setting up config files for Debain-Based Distros"
	sudo apt update
	
#Install main packages on Debian-based Distros

	for PKGS in ${GLOBAL_PACKAGES[@]}
	do
		sudo apt install $PKGS
		echo "Installing ${PKGS}..."
	done
	
#Install Node specific packages on Debian-based Distros

	for PKGS in ${REQUIRED_NODE_PACKAGES[@]}
	do
		sudo apt install $PKGS
		echo "Installing ${PKGS}..."
	done

#Install Miscallenous

	sudo pip3 install -U Commitizen


## Symlink Debain Specific config dotfiles

# Symlink files within dotfiles dir to $USER dir

	for files in ${DEBIAN_DOTFILES[@]}
	do
		ln -sf ~/dotfiles/$files ~/
	done

# Symlink config files within dotfiles dir to .config dir

	for files in ${DEBIAN_CONFIG_DOTFILES[@]}
	do
		ln -sf ~/dotfiles/.config/$files ~/.config/
	done


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
	
elif [ -e /bin/pacman.d ]
then 
	echo "Setting up config files for Arch-Based Distros"
	
# Install necessary dependecies for Arch Linux

#(pacman -S base base-devel git wget htop bspwm 
#sxhkd neovim polybar ranger redshift dunst)

# Check which shell is currently running
# if [echo $SHELL = /usr/bin/zsh ]...


if [ -d ~/.config/ ]
then
	echo "Will symlink files to present .config directory"
else
	echo "making new .config directory..."
	mkdir ~/.config
fi

if [ -d ~/.local/ ]
then
	echo "Will symlink files to present .local directory"
else
	echo "making new .local directory..."
	mkdir ~/.local/
fi

# Symlink files in the dotfiles directory

for files in ""${ARCH_DOTFILES[@]}
do
	ln -sf ~/dotfiles/$files ~/
done

# Symlink files within directories in the dotfiles directory

for files in "${ARCH_CONFIG_DOTFILES[@]}"
do
	ln -sf ~/dotfiles/.config/$files ~/.config/
done

# Symlink files within directories in the .local directory

for files in "${ARCH_LOCAL_DOTFILES[@]}"
do 
	ln -sf ~/dotfiles/.local/$files ~/.local/
done

echo "Setup Succesful!!!"
fi


