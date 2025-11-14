#!/usr/bin/bash
install_fedora_packages(){
    sudo dnf install -y httpd clamav clamav-update clamd firewall-applet \
    gnome-extensions-app gnome-shell-extension-appindicator gnome-tweaks dconf-editor
}

if [ "$1" == "fedora" ]
then
    install_fedora_packages
elif [ "$1" == "opensuse" ]
then
    echo "unfinished"
else
    echo "error"
fi