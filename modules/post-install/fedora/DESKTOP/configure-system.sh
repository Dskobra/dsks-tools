#!/usr/bin/bash
configure_nonatomic(){
    ## setup drive mount points/permissions
    mkdir /home/jordan/Drives/
    mkdir /home/jordan/Drives/data
    mkdir /home/jordan/Drives/games
    mkdir /home/jordan/Drives/vms
    mkdir /home/jordan/Drives/shared
    echo "LABEL=data                                  /home/jordan/Drives/data             btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
    echo "LABEL=games                                 /home/jordan/Drives/games            btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
    echo "LABEL=vms                                   /home/jordan/Drives/vms              btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
    echo "LABEL=shared                                /home/jordan/Drives/shared           ntfs    nofail,users,exec             0 0 " | sudo tee -a /etc/fstab > /dev/null

    sudo sed -i '/GRUB_CMDLINE_LINUX="rhgb quiet"/c GRUB_CMDLINE_LINUX="amd_iommu=on iommu=pt amdgpu.ppfeaturemask=0xffffffff crashkernel=512M rhgb quiet"' /etc/default/grub
    sudo grub2-mkconfig -o /etc/grub2.cfg
    #sudo grubby --args="amd_iommu=on iommu=pt amdgpu.ppfeaturemask=0xffffffff crashkernel=512M rhgb quiet" --update-kernel=ALL
}

configure_atomic(){
    ## setup drive mount points/permissions
    mkdir /var/home/jordan/Drives/
    mkdir /var/home/jordan/Drives/data
    mkdir /var/home/jordan/Drives/games
    mkdir /var/home/jordan/Drives/vms
    mkdir /var/home/jordan/Drives/shared
    echo "LABEL=data                                  /var/home/jordan/Drives/data             btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
    echo "LABEL=games                                 /var/home/jordan/Drives/games            btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
    echo "LABEL=vms                                   /var/home/jordan/Drives/vms              btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
    echo "LABEL=shared                                /var//home/jordan/Drives/shared          ntfs    nofail,users,exec             0 0 " | sudo tee -a /etc/fstab > /dev/null
    sudo systemctl daemon-reload
    sudo mount -av

    sudo rpm-ostree kargs --append="amd_iommu=on iommu=pt amdgpu.ppfeaturemask=0xffffffff crashkernel=512M"
}

configure_system(){
    sudo systemctl daemon-reload
    sudo mount -av
    cp -r "$TOOLS_FOLDER/modules/game-profiles/DESKTOP" "$HOME"/.config/MangoHud/
}


if [ "$1" == "fedora-dnf" ]
then
    configure_nonatomic
    configure_system
elif [ "$1" == "fedora-ostree" ]
then
    configure_atomic
    configure_system
else
    echo "error"
fi
