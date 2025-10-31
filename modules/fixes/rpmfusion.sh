#!/usr/bin/bash

rpmfusion_purge(){
    sudo dnf remove -y akmod-nvidia akmod-nvidia-open kmod-nvidia nvidia-settings\
    nvidia-modprobe nvidia-persistenced akmod-v4l2loopback v4l2loopback
    sudo dnf remove -y rpmfusion*
}

remove_codecs(){
    sudo dnf swap -y ffmpeg ffmpeg-free --allowerasing
    sudo dnf remove -y gstreamer1-plugins-bad-freeworld\
    gstreamer1-plugins-bad-freeworld.i686

    sudo dnf swap -y mesa-va-drivers-freeworld mesa-va-drivers
    sudo dnf swap -y mesa-va-drivers-freeworld.i686 mesa-va-drivers.i686

    sudo dnf swap -y mesa-vdpau-drivers-freeworld mesa-vdpau-drivers
    sudo dnf swap -y mesa-vdpau-drivers-freeworld.i686 mesa-vdpau-drivers.i686


    sudo dnf swap -y mesa-vulkan-drivers-freeworld mesa-vulkan-drivers
    sudo dnf swap -y mesa-vulkan-drivers-freeworld.i686 mesa-vulkan-drivers.i686
}
remove_codecs
rpmfusion_purge
