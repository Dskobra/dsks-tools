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
    sudo zypper -n install  openSUSE-repos-Tumbleweed-NVIDIA
    sudo zypper -n --gpg-auto-import-keys ref
    sudo zypper -n install --auto-agree-with-licenses nvidia-open-driver-G06-signed-kmp-meta nvidia-open-driver-G06-signed-kmp-longterm \
    nvidia-open-driver-G06-signed-kmp-default nvidia-userspace-meta-G06 nvidia-modprobe nvidia-persistenced nvidia-settings

    #sudo zypper -n install --auto-agree-with-licenses dkms nvidia-settings nvidia-driver-G06-kmp-default \
    #nvidia-driver-G06-kmp-longterm nvidia-userspace-meta-G06
}
if [ "$1" == "fedora" ]
then
    install_fedora_nvidia
elif [ "$1" == "opensuse" ]
then
    install_opensuse_nvidia
else
    echo "error"
fi