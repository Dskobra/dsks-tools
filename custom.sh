#!/usr/bin/bash

# backup the default fedora provided grub and kde google provider configurations
sudo mv "/etc/default/grub" "/etc/default/grub.default.bak"
sudo mv "/usr/share/accounts/providers/kde/google.provider" "/usr/share/accounts/providers/kde/google.provider.bak"

# copy my custom grub and selinux changes into their folders
cd "configs" || exit
sudo cp "grub" "/etc/default/grub"
sudo cp "selinux_config" "/etc/selinux/config"


## setup corectrl by running the corectrl.py script
python3 corectrl.py
sudo cp "90-corectrl.rules" "/etc/polkit-1/rules.d/90-corectrl.rules"


## issue with kde atm where google blocks connecting plasma to your account.
# switching to the gnome provider seems to work
sudo cp "google.provider" "/usr/share/accounts/providers/kde/google.provider"

# set the configuration files permissions to root
sudo chown root:root "/etc/default/grub"
sudo chown root:root "/etc/polkit-1/rules.d/90-corectrl.rules"
sudo chown root:root "/etc/selinux/config"
sudo chown root:root "/usr/share/accounts/providers/kde/google.provider"

# rebuild grub with the new changes
sudo grub2-mkconfig -o /etc/grub2.cfg


