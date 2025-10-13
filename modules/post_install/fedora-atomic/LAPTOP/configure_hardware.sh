#!/usr/bin/bash
configure_boot(){
    echo "set timeout=12" | sudo tee /boot/grub2/user.cfg > /dev/null
    sudo rpm-ostree kargs --append="amd_iommu=on iommu=pt rd.driver.blacklist=nouveau,nova_core modprobe.blacklist=nouveau,nova_core nvidia-drm.modeset crashkernel=512M"
}

"$TOOLS_FOLDER"/modules/post_install/fedora-atomic/shared/configure_hardware.sh
configure_boot
