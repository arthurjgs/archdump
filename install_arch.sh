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
		By & for sins
"

loadkeys fr-pc
timedatectl set-ntp true
echo "PARTITIONING..."
echo "CREATING EFI PARTITION ..."
mkfs.vfat -F32 /dev/nvme0n1p1
echo "CREATING SWAP ..."
mkswap /dev/nvme0n1p2
echo "CREATING / PARTITION ..."
mkfs.ext4 /dev/nvme0n1p3
mount /dev/nvme0n1p3 /mnt
mkdir -p /mnt/boot/efi && mount -t vfat /dev/nvme0n1p2 /mnt/boot/efi
echo "PACSTRAP..."
pacstrap /mnt base linux linux-firmware base-devel sudo
genfstab -U -p /mnt >> /mnt/etc/fstab
cp install_chroot.sh /mnt
chmod a+x /mnt/install_chroot.sh
arch-chroot /mnt
