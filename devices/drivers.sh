#!/usr/bin/bash
install_nvidia_fedora(){
    sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf install -y akmod-nvidia nvidia-settings xorg-x11-drv-nvidia xorg-x11-drv-nvidia-cuda
    sudo sh -c 'echo "%_with_kmod_nvidia_open 1" > /etc/rpm/macros.nvidia-kmod'
    sudo dnf install -y rpmfusion-nonfree-release-tainted
    sudo dnf install -y akmod-nvidia-open
    sudo akmods --rebuild --force
    sudo dracut --regenerate-all --force
    sudo reboot
}

install_nvidia_opensuse(){
    # main drivers
    sudo zypper al nvidia-open-driver-G06-signed-kmp-default
    sudo zypper al nvidia-open-driver-G07-signed-kmp-default

    sudo zypper al nvidia-open-driver-G06-signed-kmp-longterm
    sudo zypper al nvidia-open-driver-G07-signed-kmp-longterm

    sudo zypper al nvidia-open-driver-G06-signed-cuda-kmp-default
    sudo zypper al nvidia-open-driver-G07-signed-cuda-kmp-default

    # cuda drivers
    sudo zypper al nvidia-open-driver-G06-signed-cuda-kmp-longterm
    sudo zypper al nvidia-open-driver-G07-signed-cuda-kmp-longterm

    sudo zypper dup
    sudo zypper --gpg-auto-import-keys -n ref
    sudo zypper -n install --auto-agree-with-licenses dkms nvidia-settings nvidia-driver-G06-kmp-default \
    nvidia-driver-G06-kmp-longterm nvidia-userspace-meta-G06
}

install_lact_fedora(){
    sudo dnf copr enable -y ilyaz/LACT
    sudo dnf install -y lact
    sudo systemctl enable --now lactd

}

install_lact_opensuse(){
    sudo zypper -n install dbus-1-daemon
    flatpak install -y flathub io.github.ilya_zlobintsev.LACT

}
if [ "$1" == "lact" ] || [ "$DISTRO" == "fedora" ]
then
    install_lact_fedora
elif [ "$1" == "lact" ] || [ "$DISTRO" == "opensuse-tumbleweed" ]
then
    install_lact_opensuse
elif [ "$1" == "nvidia" ] || [ "$DISTRO" == "fedora" ]
then
    install_nvidia_fedora
elif [ "$1" == "nvidia" ] || [ "$DISTRO" == "opensuse-tumbleweed" ]
then
    install_nvidia_opensuse
else
    echo "error"
fi