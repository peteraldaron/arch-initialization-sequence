#!/bin/bash

locale-gen

NAME=name
PWD=pass

# user
useradd -m $NAME
echo "root:"$PASS | chpasswd
echo $NAME":"$PASS | chpasswd
echo $NAME" ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# grub
pacman -S --noconfirm grub os-prober efibootmgr
mkdir -p /boot/efi
mount -t vfat /dev/sda1 /boot/efi
grub-install --target=x86_64-efi --efi-directory=/boot/efi \
             --bootloader-id=grub --debug --recheck
grub-mkconfig -o /boot/grub/grub.cfg

# tz
pacman -S --noconfirm ntp
rm -f /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Helsinki /etc/localtime

# systemctl
systemctl enable ntpd NetworkManager
