#!/usr/bin/bash

distro_updater(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf clean all
        sudo dnf update -y
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ] || [ "$DISTRO" == "opensuse-leap" ]
    then
        sudo zypper ref
        sudo zypper -n dup
    else
        echo "Unsupported distro"
    fi

}

DISTRO=$(source /etc/os-release ; echo $ID)
flatpak update -y
flatpak remove --unused -y  
sudo -v ; curl https://rclone.org/install.sh | sudo bash
distro_updater