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
pvcreate /dev/sda8
vgcreate VolGroup00 /dev/sda
lvcreate -L 9G VolGroup00 -n root
lvcreate -L 5G VolGroup00 -n home
lvcreate -L 400Mo VolGroup00 -n boot
lvcreate -L 500Mo VolGroup00 -n swap
echo "Formating boot..."
mkfs.ext2 /dev/VolGroup00/boot
echo "Formating root..."
mkfs.ext4 /dev/VolGroup00/root
echo "Formating home..."
mkfs.ext4 /dev/VolGroup00/home
echo "Formating swap..."
mkswap /dev/VolGroup00/swap
swapon /dev/VolGroup00/swap
echo "Mounting ..."
mount /dev/VolGroup00/root /mnt
mkdir /mnt/boot
mount /dev/VolGroup00/boot /mnt/boot
mkdir /mnt/home
mount /dev/VolGroup00/home /mnt/home
echo "PacStrap ..."
pacstrap /mnt base linux linux-firmware base-devel sudo
genfstab -U -p /mnt >> /mnt/etc/fstab
cp lvm_install_chroot.sh /mnt
chmod a+x /mnt/lvm_install_chroot/sh
arch-chroot /mnt /bin/bash
