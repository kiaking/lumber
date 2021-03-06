#!/usr/bin/env bash

# Update package list.

apt-get update

# Update Grub Bootloader.

echo "set grub-pc/install_devices /dev/sda" | debconf-communicate
apt-get -y remove grub-pc
apt-get -y install grub-pc
grub-install /dev/sda
update-grub

# Upgrade system packages.

apt-get -y upgrade
