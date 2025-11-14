#!/usr/bin/bash
install_fedora_nvidia(){
    sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf install -y akmod-nvidia nvidia-settings xorg-x11-drv-nvidia xorg-x11-drv-nvidia-cuda
    sudo sh -c 'echo "%_with_kmod_nvidia_open 1" > /etc/rpm/macros.nvidia-kmod'
    sudo dnf install -y rpmfusion-nonfree-release-tainted
    sudo dnf install -y akmod-nvidia-open
    sudo akmods --rebuild --force
    sudo dracut --regenerate-all --force
    sudo reboot
}

install_opensuse_nvidia(){
    echo ""
}
if [ "$1" == "fedora" ]
then
    install_fedora_nvidia
if [ "$1" == "opensuse" ]
then
    echo "unfinished"
    #install_opensuse_nvidia
else
    echo "error"
fi