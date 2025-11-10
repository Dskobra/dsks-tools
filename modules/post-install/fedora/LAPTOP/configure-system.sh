#!/usr/bin/bash
#sudo sed -i '/GRUB_CMDLINE_LINUX="rhgb quiet rd.driver.blacklist=nouveau,nova_core modprobe.blacklist=nouveau,nova_core"/c GRUB_CMDLINE_LINUX="amd_iommu=on iommu=pt rd.driver.blacklist=nouveau,nova_core modprobe.blacklist=nouveau,nova_core crashkernel=512M rhgb quiet"' /etc/default/grub
#sudo grubby --args="amd_iommu=on iommu=pt rd.driver.blacklist=nouveau,nova_core modprobe.blacklist=nouveau,nova_core crashkernel=512M rhgb quiet" --update-kernel=ALL
sudo cp /etc/default/grub /etc/default/grub-og.bak
sudo cp "$TOOLS_FOLDER"/modules/post-install/fedora/LAPTOP/grub-laptop /etc/default/grub
sudo chown root:root /etc/default/grub
sudo grub2-mkconfig -o /etc/grub2.cfg
cp -r "$TOOLS_FOLDER/modules/game-profiles/LAPTOP" "$HOME"/.config/MangoHud/

# seems flatpak only sees nvidia drivers once installed on system. So run an update during the last step of these
# setup scripts
flatpak update -y   


