#!/usr/bin/bash

configure_fedora_grub(){
    #sudo sed -i '/GRUB_CMDLINE_LINUX="rhgb quiet rd.driver.blacklist=nouveau,nova_core modprobe.blacklist=nouveau,nova_core"/c GRUB_CMDLINE_LINUX="amd_iommu=on iommu=pt rd.driver.blacklist=nouveau,nova_core modprobe.blacklist=nouveau,nova_core crashkernel=512M rhgb quiet"' /etc/default/grub
    #sudo grubby --args="amd_iommu=on iommu=pt rd.driver.blacklist=nouveau,nova_core modprobe.blacklist=nouveau,nova_core crashkernel=512M rhgb quiet" --update-kernel=ALL
    sudo cp /etc/default/grub /etc/default/grub-og.bak
    sudo cp "$TOOLS_FOLDER"/modules/post-install/LAPTOP/grub-fedora-laptop /etc/default/grub
    sudo chown root:root /etc/default/grub
    sudo grub2-mkconfig -o /etc/grub2.cfg
}

if [ "$1" == "fedora" ]
then
    configure_fedora_grub
    cp -r "$TOOLS_FOLDER/modules/configs/game-profiles/LAPTOP" "$HOME"/.config/MangoHud/
    flatpak update -y       #flatpak nvidia drivers needs to match system so do an update
elif [ "$1" == "opensuse" ]
then
    cp -r "$TOOLS_FOLDER/modules/configs/game-profiles/LAPTOP" "$HOME"/.config/MangoHud/
    flatpak update -y       #flatpak nvidia drivers needs to match system so do an update
else
    echo "error"
fi