#!/bin/bash

# Install necessary dependecies

#(pacman -S base base-devel git wget htop bspwm 
#sxhkd neovim polybar ranger redshift dunst)

# Check which shell is currently running
# if [echo $SHELL = /usr/bin/zsh ]...

dots=(".xinitrc" ".screenlayout" ".zshrc" ".zprofile" ".bash_profile" ".gitconfig")
config_dots=("bspwm" "sxhkd" "nvim" "polybar" "ranger" "redshift" "dunst" "kitty" "neofetch" "rofi") 
local_dots=("bin")

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

for files in ""${dots[@]}
do
	ln -sf ~/dotfiles/$files ~/
done

# Symlink files within directories in the dotfiles directory

for files in "${config_dots[@]}"
do
	ln -sf ~/dotfiles/.config/$files ~/.config/
done

# Symlink files within directories in the .local directory

for files in "${local_dots[@]}"
do 
	ln -sf ~/dotfiles/.local/$files ~/.local/
done

echo "Setup Succesful!!!"
