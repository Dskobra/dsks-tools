#!/usr/bin/bash

# backup the default fedora provided grub and kde google provider configurations
sudo mv "/etc/default/grub" "/etc/default/grub.default.bak"

# copy my custom grub and selinux changes into their folders
cd "configs" || exit
sudo cp "grub" "/etc/default/grub"


# set the configuration files permissions to root
sudo chown root:root "/etc/default/grub"

# rebuild grub with the new changes
sudo grub2-mkconfig -o /etc/grub2.cfg


