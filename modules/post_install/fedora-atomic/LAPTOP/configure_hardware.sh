#!/usr/bin/bash
configure_boot(){
    echo "set timeout=12" | sudo tee /boot/grub2/user.cfg > /dev/null
    sudo rpm-ostree kargs --append="amd_iommu=on iommu=pt rd.driver.blacklist=nouveau,nova_core modprobe.blacklist=nouveau,nova_core nvidia-drm.modeset acpi_enforce_resources=lax crashkernel=512M"
}
configure_drives(){
    ## setup drive mount points/permissions
    mkdir -p /var/home/jordan/Drives/data_drive
    echo "LABEL=data_drive                              /var/home/jordan/Drives/data_drive      btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
    sudo systemctl daemon-reload
    sudo mount -av
}

"$TOOLS_FOLDER"/modules/post_install/fedora/shared/configure_hardware.sh
configure_boot
configure_drives
