#!/usr/bin/bash
install_nvidia(){
    # dev tools are sometimes broken due to mismatches
    #sudo sh -c 'echo "%_with_kmod_nvidia_open 1" > /etc/rpm/macros.nvidia-kmod'
    #sudo rpm-ostree install rpmfusion-nonfree-release-tainted
    #sudo rpm-ostree apply-live
    sudo rpm-ostree install akmod-nvidia-open xorg-x11-drv-nvidia akmod-nvidia xorg-x11-drv-nvidia-cuda
    sudo rpm-ostree kargs --append="amd_iommu=on iommu=pt rd.driver.blacklist=nouveau,nova_core modprobe.blacklist=nouveau,nova_core crashkernel=512M"

}

install_nvidia
