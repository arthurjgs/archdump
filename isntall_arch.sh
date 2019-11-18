#!/bin/bash

loadkeys fr-pc
timedatectl set-ntp true
echo "PARTITIONING..."
mkfs.vfat -F32 /dev/nvme0n1p2
mkfs.ext4 /dev/nvme0n1p5
mount /dev/nvme0n1p5 /mnt
mkdir -p /mnt/boot/efi && mount -t vfat /dev/nvme0n1p2 /mnt/boot/efi
echo "PACSTRAP..."
pacstrap /mnt base linux linux-firmware base-devel sudo
genfstab -U -p /mnt >> /mnt/etc/fstab
cp install_chroot.sh /mnt
chmod a+x /mnt/install_chroot.sh
arch-chroot /mnt
