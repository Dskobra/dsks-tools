#!/usr/bin/bash
configure_drives(){
    ## setup drive mount points/permissions
    sudo mkdir data games vms shared
    sudo /mnt/data /mnt/games /mnt/vms /mnt/shared
    sudo chown "$USER":"$USER" /mnt/data /mnt/games /mnt/vms /mnt/shared -R
    echo "LABEL=data                                  /mnt/data             btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
    echo "LABEL=games                                 /mnt/games            btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
    echo "LABEL=vms                                   /mnt/vms              btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
    echo "LABEL=shared                                /mnt/shared           ntfs    nofail,users,exec             0 0 " | sudo tee -a /etc/fstab > /dev/null
}

configure_fedora_grub(){
    sudo cp /etc/default/grub /etc/default/grub-og.bak
    sudo grubby --args="amd_iommu=on iommu=pt amdgpu.ppfeaturemask=0xffffffff rhgb quiet" --update-kernel=ALL
}

configure_opensuse_grub(){
    echo "amd_iommu=on iommu=pt amdgpu.ppfeaturemask=0xffffffff splash=silent mitigations=auto quiet security=selinux selinux=1" | sudo tee /etc/kernel/cmdline > /dev/null
}

configure_system(){
    sudo systemctl daemon-reload
    sudo mount -av
    sudo systemctl enable --now coolercontrold
    cp -r "$TOOLS_FOLDER/modules/configs/game-profiles/DESKTOP" "$HOME"/.config/MangoHud/
}

if [ "$1" == "fedora" ]
then
    configure_drives
    configure_fedora_grub
    configure_system
elif [ "$1" == "opensuse" ]
then
    configure_drives
    configure_opensuse_grub
    configure_system
else
    echo "error"
fi
