sed -i '/ en_US /s/^/#/' /etc/locale.gen
locale-gen
echo LANG="en_US.UTF-8" > /etc/locale.conf
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc --utc
sudo pacman -Sy efibootmgr grub os-prober --noconfirm
pacman -Sy lvm2 --noconfirm
sudo pacman -Syu --noconfirm --needed
echo labasr.lan > /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
export LANG=en_US.UTF-8
echo KAYMAP=fr > /etc/vconsole.conf
mkinitcpio -p linux
grub-install --target=i386-pc /dev/sdX
grub-mkconfig -o /boot/grub/grub.cfg
useradd -m  -G wheel,users -s /bin/bash romain
echo "romain ALL=(ALL) ALL" >> /etc/sudoers
passwd
exit
