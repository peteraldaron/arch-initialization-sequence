#!/bin/bash

locale-gen

NAME=name
PWD=pass

# user
useradd -m $NAME
echo "root:"$PASS | chpasswd
echo $NAME":"$PASS | chpasswd
echo $NAME" ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers

# grub
pacman -S --noconfirm grub
mount -t vfat /dev/sda1 /boot/efi
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=grub

# tz
ln -s /usr/share/zoneinfo/Europe/Helsinki /etc/localtime
pacman -S --noconfirm ntp

# systemctl
systemctl enable ntpd NetworkManager
