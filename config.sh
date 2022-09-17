#!/bin/bash

# Debian-Based Distros

REQUIRED_PACKAGES=("nodejs" "nvim")
REQUIRED_NODE_PACKAGES=("yarn")

ARCH_DOTFILES=(".xinitrc" ".screenlayout" ".zshrc" ".zprofile" ".bash_profile" ".gitconfig")
ARCH_CONFIG_DOTFILES=("bspwm" "sxhkd" "nvim" "polybar" "ranger" "redshift" "dunst" "kitty" "neofetch" "rofi")
ARCH_LOCAL_DOTFILES=("bin")

if [ -e /bin/apt ]
then
	echo "Setting up config files for Debain-Based Distros"
	#for FILES in "${REQUIRED_PACKAGES[@]}"
	
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


