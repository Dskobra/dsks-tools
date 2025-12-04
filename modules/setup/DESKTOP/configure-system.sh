#!/usr/bin/bash
configure_drives(){
    ## setup drive mount points/permissions
    mkdir /home/jordan/Drives/
    mkdir /home/jordan/Drives/data
    mkdir /home/jordan/Drives/games
    mkdir /home/jordan/Drives/vms
    mkdir /home/jordan/Drives/shared
    echo "LABEL=data                                  /home/jordan/Drives/data             btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
    echo "LABEL=games                                 /home/jordan/Drives/games            btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
    #echo "LABEL=vms                                   /home/jordan/Drives/vms              btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
    #echo "LABEL=shared                                /home/jordan/Drives/shared           ntfs    nofail,users,exec             0 0 " | sudo tee -a /etc/fstab > /dev/null
}

configure_fedora_grub(){
    #sudo sed -i '/GRUB_CMDLINE_LINUX="rhgb quiet"/c GRUB_CMDLINE_LINUX="amd_iommu=on iommu=pt amdgpu.ppfeaturemask=0xffffffff crashkernel=512M rhgb quiet"' /etc/default/grub
    #sudo grubby --args="amd_iommu=on iommu=pt amdgpu.ppfeaturemask=0xffffffff crashkernel=512M rhgb quiet" --update-kernel=ALL
    sudo cp /etc/default/grub /etc/default/grub-og.bak
    sudo cp "$TOOLS_FOLDER"/modules/setup/DESKTOP/grub-fedora-desktop /etc/default/grub
    sudo chown root:root /etc/default/grub
    sudo grub2-mkconfig -o /etc/grub2.cfg
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
    configure_system
else
    echo "error"
fi
