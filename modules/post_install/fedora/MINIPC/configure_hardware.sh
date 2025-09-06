#!/usr/bin/bash

configure_boot(){
    sudo sed -i '/GRUB_CMDLINE_LINUX="rhgb quiet"/c GRUB_CMDLINE_LINUX="amd_iommu=on iommu=pt crashkernel=512M rhgb quiet"' /etc/default/grub
    sudo sed -i '/GRUB_TIMEOUT=5/c GRUB_TIMEOUT=12' /etc/default/grub
    sudo grub2-mkconfig -o /etc/grub2.cfg
}

configure_boot
