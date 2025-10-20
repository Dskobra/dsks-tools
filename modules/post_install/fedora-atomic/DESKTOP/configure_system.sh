#!/usr/bin/bash
configure_drives(){
    ## setup drive mount points/permissions
    mkdir /var/home/jordan/Drives/
    mkdir /var/home/jordan/Drives/data
    mkdir /var/home/jordan/Drives/games
    mkdir /var/home/jordan/Drives/vms
    mkdir var/home/jordan/Drives/shared
    echo "LABEL=data                                  /var/home/jordan/Drives/data             btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
    echo "LABEL=games                                 /var/home/jordan/Drives/games            btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
    echo "LABEL=vms                                   /var/home/jordan/Drives/vms              btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
    echo "LABEL=shared                                /var//home/jordan/Drives/shared          ntfs    nofail,users,exec             0 0 " | sudo tee -a /etc/fstab > /dev/null
    sudo systemctl daemon-reload
    sudo mount -av
}

configure_drives
cp -r "$TOOLS_FOLDER/modules/configs/game-profiles/DESKTOP" "$HOME"/.config/MangoHud/
ln -s "$HOME"/.var/app/org.gnome.Boxes/data/gnome-boxes/images/  "$HOME"/Drives/vms/boxes
sudo rpm-ostree kargs --append="amd_iommu=on iommu=pt amdgpu.ppfeaturemask=0xffffffff crashkernel=512M"