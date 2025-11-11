#!/usr/bin/bash
### shared packages between my devices.
install_packages(){
    cd "$TOOLS_FOLDER/temp" || exit
    sudo zypper -n install --auto-agree-with-licenses setroubleshoot-server git git-gui gh git-cola python313-idle \
    patterns-containers-container_runtime distrobox OpenRGB cpu-x remmina steam steam-devices gamemode goverlay \
    virt-manager docker-compose-switch ShellCheck clamav firewall-applet i2c-tools python313-python-lsp-server \
    systemd-zram-service zram-generator v4l2loopback-kmp-default v4l2loopback-kmp-longterm v4l2loopback-autoload \
    python313-devel opi vlc kdump

    sudo opi -n megasync
    sudo opi -n brave

    if [ "$XDG_CURRENT_DESKTOP" == "KDE" ]
    then
        sudo zypper -n install k3b kate kate-plugins kdiff3 kleopatra
    elif [ "$XDG_CURRENT_DESKTOP" == "GNOME" ]
    then
        sudo zypper -n install gnome-tweaks dconf-editor file-roller xfburn snapshot yaru-icon-theme \
        kde-partitionmanager
    else
        echo "$XDG_CURRENT_DESKTOP is not supported."
    fi
    curl -L -o proton-mail.rpm https://proton.me/download/mail/linux/1.9.0/ProtonMail-desktop-beta.rpm
    curl -L -o proton-pass.rpm https://proton.me/download/pass/linux/proton-pass-1.32.3-1.x86_64.rpm
    curl -L -o proton-authenticator.rpm https://proton.me/download/authenticator/linux/ProtonAuthenticator-1.0.0-1.x86_64.rpm


    sudo zypper -n --no-gpg-checks install  *.rpm
    rm *.rpm
}

cleanup(){
    sudo zypper -n rm lftp kmahjongg kmines kreversi ksudoku icewm icewm-config-upstream \
    yast2-firewall yast2-network yast2-country yast2-printer yast2-proxy yast2-scanner \
    yast2-services-manager xscreensaver xscreensaver-data gnome-mahjongg swell-foop \
    quadrapassel gnome-mines gnome-chess lightsoff gnome-sudoku cheese gnome-extensions \
    totem gnome-photos xterm yast2-kdump
}

DESKTOP_TYPE=$(echo $XDG_CURRENT_DESKTOP)
echo "Desktop is $DESKTOP_TYPE"
install_packages
install_flatpaks
cleanup


