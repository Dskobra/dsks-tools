#!/usr/bin/bash
attempt_to_install_broken_apps(){
    # dev tools are sometimes broken due to mismatches
    sudo rpm-ostree install akmod-nvidia xorg-x11-drv-nvidia akmod-nvidia xorg-x11-drv-nvidia-cuda

    #sudo dnf install -y akmod-nvidia nvidia-settings xorg-x11-drv-nvidia-cuda
    #sudo sh -c 'echo "%_with_kmod_nvidia_open 1" > /etc/rpm/macros.nvidia-kmod'
    #sudo dnf install -y rpmfusion-nonfree-release-tainted
    #sudo dnf install -y akmod-nvidia-open
    #sudo akmods --rebuild --force
    #sudo dracut --regenerate-all --force
}

"$TOOLS_FOLDER"/modules/post_install/fedora-atomic/shared/install_packages.sh
attempt_to_install_broken_apps
