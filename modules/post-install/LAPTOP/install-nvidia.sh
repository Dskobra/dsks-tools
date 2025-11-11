#!/usr/bin/bash
install_nvidia_dnf(){
    sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf install -y akmod-nvidia nvidia-settings xorg-x11-drv-nvidia xorg-x11-drv-nvidia-cuda
    sudo sh -c 'echo "%_with_kmod_nvidia_open 1" > /etc/rpm/macros.nvidia-kmod'
    sudo dnf install -y rpmfusion-nonfree-release-tainted
    sudo dnf install -y akmod-nvidia-open
    sudo akmods --rebuild --force
    sudo dracut --regenerate-all --force
    sudo reboot
}
install_nvidia_ostree(){
    sudo rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo rpm-ostree apply-live
    sudo rpm-ostree install akmod-nvidia-open xorg-x11-drv-nvidia akmod-nvidia xorg-x11-drv-nvidia-cuda
    sudo rpm-ostree kargs --append="amd_iommu=on iommu=pt rd.driver.blacklist=nouveau,nova_core modprobe.blacklist=nouveau,nova_core crashkernel=512M"

}

if [ "$1" == "fedora-dnf" ]
then
    install_nvidia_dnf
elif [ "$1" == "fedora-ostree" ]
then
    install_nvidia_ostree
else
    echo "error"
fi