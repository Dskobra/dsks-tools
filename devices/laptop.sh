#!/usr/bin/bash

configure_fedora_grub(){
    sudo cp /etc/default/grub /etc/default/grub-og.bak
    sudo grubby --args="amd_iommu=on iommu=pt rd.driver.blacklist=nouveau,nova_core modprobe.blacklist=nouveau,nova_core rhgb quiet" --update-kernel=ALL
}
configure_opensuse_grub(){
    echo "amd_iommu=on iommu=pt rd.driver.blacklist=nouveau,nova_core modprobe.blacklist=nouveau,nova_core splash=silent mitigations=auto quiet security=selinux selinux=1" | sudo tee /etc/kernel/cmdline > /dev/null
}

if [ "$DISTRO" == "fedora" ]
then
    configure_fedora_grub
    cp -r "$TOOLS_FOLDER"/configs/game-profiles/LAPTOP "$HOME"/.config/MangoHud/
    flatpak update -y       #flatpak nvidia drivers needs to match system so do an update
elif [ "$DISTRO" == "opensuse-tumbleweed" ]
then
    configure_opensuse_grub
    cp -r "$TOOLS_FOLDER"/configs/game-profiles/LAPTOP "$HOME"/.config/MangoHud/
    sudo flatpak update -y       #flatpak nvidia drivers needs to match system so do an update
else
    echo "error"
fi