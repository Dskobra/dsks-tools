#!/usr/bin/bash

### Create a container for apps that require codecs
install_packages(){
    sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf install -y rpmfusion-free-release-tainted 
    
    sudo dnf install -y discord steam steam-devices gamemode.x86_64 gamemode.i686 openshot vlc libdvdcss

    sudo dnf -y swap ffmpeg-free ffmpeg --allowerasing
    
    sudo dnf swap -y mesa-va-drivers mesa-va-drivers-freeworld
    sudo dnf swap -y mesa-va-drivers.i686 mesa-va-drivers-freeworld.i686

    sudo dnf swap -y mesa-vulkan-drivers mesa-vulkan-drivers-freeworld
    sudo dnf swap -y mesa-vulkan-drivers.i686 mesa-vulkan-drivers-freeworld.i686
    sudo dnf install -y ffmpeg-libs.i686 gstreamer1-plugins-bad-freeworld gstreamer1-plugins-bad-freeworld.i686

    # multimedia/games
    distrobox-export --app steam
    distrobox-export --app Discord
    distrobox-export --app openshot 
    distrobox-export --app vlc 
}

if [ -z "$container" ]
then
    echo "Not in a container. Closing."
elif [ -n "$container" ]
then
    install_packages
else 
    echo ""
fi