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

configure_grub_fedora(){
    sudo cp /etc/default/grub /etc/default/grub-og.bak
    sudo grubby --args="amd_iommu=on iommu=pt amdgpu.ppfeaturemask=0xffffffff rhgb quiet" --update-kernel=ALL
}

configure_grub_opensuse(){
    echo "amd_iommu=on iommu=pt amdgpu.ppfeaturemask=0xffffffff splash=silent mitigations=auto quiet security=selinux selinux=1" | sudo tee /etc/kernel/cmdline > /dev/null
}

configure_system(){
    sudo systemctl daemon-reload
    sudo mount -av
    cp -r "$HOME"/.local/share/dsks-tools/configs/game-profiles/DESKTOP "$HOME"/.config/MangoHud/
}

if [ "$DISTRO" == "fedora" ]
then
    #configure_drives
    configure_grub_fedora
    configure_system
elif [ "$DISTRO" == "opensuse-tumbleweed" ]
then
    #configure_drives
    configure_grub_opensuse
    configure_system
else
    echo "error"
fi
