#!bin/bash

hwclock --systohc
sudo pacman -Sy dialog netctl dhclient wpa_supplicant wireless_tools
sudo pacman -Sy networkmanager
systemctl enable NetworkManager
sudo pacman -Sy efibootmgr grub os-prober --noconfirm
sudo pacman -Syu --noconfirm --needed
echo sins-work > /etc/hostname
echo "127.0.0.1 Sins sins-work" >> /etc/hosts
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
sed -i '/ en_US /s/^/#/' /etc/locale.gen
locale-gen
echo LANG="en_US.UTF-8" > /etc/locale.conf
export LANG=en_US.UTF-8
echo KAYMAP=fr > /etc/vconsole.conf
mkinitcpio -p linux
os-prober
useradd -m  -G wheel,users -s /bin/bash sins
echo "sins ALL=(ALL) ALL" >> /etc/sudoers
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --removable
grub-mkconfig -o /boot/grub/grub.cfg
