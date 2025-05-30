#!/usr/bin/bash

setup_zram(){
    if [ "$DISTRO" == "fedora" ]
    then
        echo "Zram is already preinstalled on Fedora"
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install systemd-zram-service zram-generator
    else
        echo "Error"
    fi

    sudo cp /usr/lib/systemd/zram-generator.conf zram-generator.conf.bak
    sudo cp "$TOOLS_FOLDER"/modules/configs/zram-generator.conf /usr/lib/systemd/zram-generator.conf
    sudo chown root:root /usr/lib/systemd/zram-generator.conf
    #sudo zramswapon        # needed for opensuse. Fedora users can just reboot.
}

setup_zram
