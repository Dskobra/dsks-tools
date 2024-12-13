#!/usr/bin/bash

# backup the default fedora provided grub and kde google provider configurations
sudo mv "/usr/share/accounts/providers/kde/google.provider" "/usr/share/accounts/providers/kde/google.provider.bak"

# copy my custom grub and selinux changes into their folders
cd "configs" || exit

## issue with kde atm where google blocks connecting plasma to your account.
# switching to the gnome provider seems to work
sudo cp "google.provider" "/usr/share/accounts/providers/kde/google.provider"
sudo chown root:root "/usr/share/accounts/providers/kde/google.provider"


