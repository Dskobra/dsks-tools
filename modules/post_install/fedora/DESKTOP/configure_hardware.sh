#!/usr/bin/bash
configure_boot(){
    sudo sed -i '/GRUB_CMDLINE_LINUX="rhgb quiet"/c GRUB_CMDLINE_LINUX="amd_iommu=on iommu=pt amdgpu.ppfeaturemask=0xffffffff acpi_enforce_resources=lax crashkernel=512M rhgb quiet"' /etc/default/grub
    sudo sed -i '/GRUB_TIMEOUT=5/c GRUB_TIMEOUT=12' /etc/default/grub
    sudo grub2-mkconfig -o /etc/grub2.cfg
}

configure_drives(){
    ## setup drive mount points/permissions
    mkdir /home/jordan/Drives/
    mkdir /home/jordan/Drives/data_drive
    mkdir /home/jordan/Drives/game_drive
    mkdir /home/jordan/Drives/vm_drive
    echo "LABEL=data_drive                               /home/jordan/Drives/data_drive       btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
    echo "LABEL=game_drive                               /home/jordan/Drives/game_drive       btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
    echo "LABEL=vm_drive                                 /home/jordan/Drives/vm_drive         btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
    sudo systemctl daemon-reload
    sudo mount -av
}

"$TOOLS_FOLDER"/modules/post_install/fedora/shared/configure_hardware.sh
configure_boot
configure_drives

