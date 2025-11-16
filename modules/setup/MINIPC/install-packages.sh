#!/usr/bin/bash
install_fedora_packages(){
    sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf install -y rpmfusion-free-release-tainted
    sudo dnf config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
    wget https://mega.nz/linux/repo/Fedora_43/x86_64/megasync-Fedora_43.x86_64.rpm && sudo dnf install -y "$PWD/megasync-Fedora_43.x86_64.rpm"
    sudo dnf install -y vim-enhanced distrobox tilix brave-browser clamav clamav-update clamd firewall-applet cockpit cockpit-files \
    cockpit-kdump cockpit-selinux cockpit-session-recording httpd wget curl dnf-plugins-core


    cd "$TOOLS_FOLDER/temp" || exit
    if [ "$XDG_CURRENT_DESKTOP" == "KDE" ]
    then
        sudo dnf install -y kate kleopatra
    elif [ "$XDG_CURRENT_DESKTOP" == "GNOME" ]
    then
        sudo dnf install -y gnome-shell-extension-appindicator gnome-tweaks dconf-editor file-roller 
    else
        echo "$XDG_CURRENT_DESKTOP is not supported."
    fi
    sudo dnf remove -y libreoffice*

}

install_opensuse_packages(){
    cd "$TOOLS_FOLDER/temp" || exit
    sudo zypper -n install --auto-agree-with-licenses apache2 opi clamav firewall-applet\
    setroubleshoot-server kdump systemd-zram-service zram-generator 

    sudo opi -n brave

    if [ "$XDG_CURRENT_DESKTOP" == "KDE" ]
    then
        sudo zypper -n install kate kate-plugins kdiff3 kleopatra
    elif [ "$XDG_CURRENT_DESKTOP" == "GNOME" ]
    then
        sudo zypper -n install gnome-tweaks dconf-editor file-roller yaru-icon-theme
    else
        echo "$XDG_CURRENT_DESKTOP is not supported."
    fi
    
    sudo zypper -n dup

    sudo zypper -n rm lftp kmahjongg kmines kreversi ksudoku icewm icewm-config-upstream \
    yast2-firewall yast2-network yast2-country yast2-printer yast2-proxy yast2-scanner \
    yast2-services-manager xscreensaver xscreensaver-data gnome-mahjongg swell-foop \
    quadrapassel gnome-mines gnome-chess lightsoff gnome-sudoku cheese gnome-extensions \
    totem gnome-photos xterm yast2-kdump
}

if [ "$1" == "fedora" ]
then
    install_fedora_packages
elif [ "$1" == "opensuse" ]
then
    install_opensuse_packages
else
    echo "error"
fi