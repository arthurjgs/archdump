#!/bin/bash

echo "##################"
echo "INSTALLING PACKAGE"
echo "##################"

sudo localectl set-keymap --no-convert keymap
setxkbmap fr

echo "###########################"
echo "INSTALLING SDDM, I3, PLASMA"
echo "###########################"

sudo pacman --color always
sudo pacman -Sy sddm i3 plasma --noconfirm
sudo systemctl enable sddm

echo "###########################"
echo "INSTALLING    YAY + PACKAGE"
echo "###########################"

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
sudo pacman -S networkmanager --noconfirm
systemctl enable NetworkManager
sudo pacman -S network-manager-applet --noconfirm
sudo pacman -S kdeplasma-addons plasma-nm --noconfirm
sudo pacman -S xorg xorg-server xorg-apps --noconfirm
sudo pacman -S xorg-xinit xorg-twm xorg-xclock xterm --noconfirm
sudo pacman -S xf86-video-intel --noconfirm
sudo pacman -S firefox --noconfirm

echo "#######"
echo "EPITECH"
echo "#######"

./epitech-install/install arthur.junges@epitech.eu
./epitech-emacs/INSTALL.sh local

