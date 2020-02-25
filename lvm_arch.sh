#!/bin/bash

echo "
	           -`
                  .o+`
                 `ooo/
                `+oooo:
               `+oooooo:
               -+oooooo+:
             `/:-:++oooo+:
            `/++++/+++++++:
           `/++++++++++++++:
          `/+++ooooooooooooo/`
         ./ooosssso++osssssso+`
        .oossssso-````/ossssss+`
       -osssssso.      :ssssssso.
      :osssssss/        osssso+++.
     /ossssssss/        +ssssooo/-
   `/ossssso+/:-        -:/+osssso+-
  `+sso+:-`                 `.-/+oso:
 `++:.                           `-/+/
		By Arthur & Mehdi
        for MyWeb
"

loadkeys fr-pc
timedatectl set-ntp true
echo "PARTITIONING..."
pvcreate /dev/sda
vgcreate VolGroup00 /dev/sda
lvcreate -L 9G VolGroup00 -n root
lvcreate -L 5G VolGroup00 -n home
lvcreate -L 400Mo VolGroup00 -n boot
lvcreate -L 500Mo VolGroup00 -n swap
echo "Mounting boot..."
mkfs.vfat -F32 /dev/VolGroup00/boot
#mount -t vfat /dev/VolGroup00/boot /boot
echo "Mounting root..."
mkfs.ext4 /dev/VolGroup00/root
mount /dev/VolGroup00/root /mnt
echo "Mouting home..."
mkfs.ext4 /dev/VolGroup00/home
#mount /dev/VolGroup00/home /mnt/home
echo "Mouting swap..."
mkswap /dev/VolGroup00/swap
#swapon /dev/VolGroup00/swap
echo "PacStrap ..."
pacstrap /mnt base linux linux-firmware base-devel sudo
genfstab -U -p /mnt >> /mnt/etc/fstab
arch-chroot /mnt
hwclock --systohc
sudo pacman -Sy efibootmgr grub os-prober --noconfirm
sudo pacman -Syu --noconfirm --needed
echo labasr.lan > /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
sed -i '/ en_US /s/^/#/' /etc/locale.gen
locale-gen
echo LANG="en_US.UTF-8" > /etc/locale.conf
export LANG=en_US.UTF-8
echo KAYMAP=fr > /etc/vconsole.conf
mkinitcpio -p linux
os-prober
useradd -m  -G wheel,users -s /bin/bash romain
echo "romain ALL=(ALL) ALL" >> /etc/sudoers
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --removable
grub-mkconfig -o /boot/grub/grub.cfg
exit
