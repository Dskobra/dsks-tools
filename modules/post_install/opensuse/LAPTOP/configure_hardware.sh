#!/usr/bin/bash
configure_boot(){
        #sudo sed -i '/GRUB_CMDLINE_LINUX="rhgb quiet rd.driver.blacklist=nouveau,nova_core modprobe.blacklist=nouveau,nova_core"/c GRUB_CMDLINE_LINUX="amd_iommu=on iommu=pt rd.driver.blacklist=nouveau,nova_core modprobe.blacklist=nouveau,nova_core nvidia-drm.modeset acpi_enforce_resources=lax crashkernel=512M rhgb quiet"' /etc/default/grub
        #sudo sed -i '/GRUB_TIMEOUT=5/c GRUB_TIMEOUT=12' /etc/default/grub
        #sudo grub2-mkconfig -o /etc/grub2.cfg

    zenity --warning --text="Copy the contents of step 1 in grub.txt into yast bootloader"
    xdg-open "$TOOLS_FOLDER"/modules/post_install/opensuse/LAPTOP/grub.txt
}

"$TOOLS_FOLDER"/modules/post_install/opensuse/shared/configure_hardware.sh
configure_boot
