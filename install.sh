#!/bin/zsh

pacstrap /mnt base base-devel gvim firefox wget git zsh xorg-server \
              nvidia net-tools inetutils networkmanager \
              network-manager-applet nmon htop \
              openssh
genfstab -U /mnt > /mnt/etc/fstab
printf "en_US.UTF-8 UTF-8" >> /mnt/etc/locale.gen
sed -i "s/^MODULES=\"\"/MODULES=\"nvidia\"/g" /mnt/etc/mkinitcpio.conf
cp ./chroot.sh /mnt/root
arch-chroot /mnt /bin/bash -c "/root/chroot.sh"
