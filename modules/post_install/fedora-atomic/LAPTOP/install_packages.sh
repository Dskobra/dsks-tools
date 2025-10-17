#!/usr/bin/bash
attempt_to_install_broken_apps(){
    # dev tools are sometimes broken due to mismatches
    sudo sh -c 'echo "%_with_kmod_nvidia_open 1" > /etc/rpm/macros.nvidia-kmod'
    sudo rpm-ostree install rpmfusion-nonfree-release-tainted
    sudo rpm-ostree apply-live
    sudo rpm-ostree install akmod-nvidia-open xorg-x11-drv-nvidia akmod-nvidia xorg-x11-drv-nvidia-cuda
    sudo rpm-ostree kargs --append="amd_iommu=on iommu=pt rd.driver.blacklist=nouveau,nova_core modprobe.blacklist=nouveau,nova_core nvidia-drm.modeset crashkernel=512M"

}

"$TOOLS_FOLDER"/modules/post_install/fedora-atomic/shared/install_packages.sh
attempt_to_install_broken_apps
zenity --warning --text="Reminder to restart terminal so it sees nodejs to install bash lsp"