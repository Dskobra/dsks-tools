#!/usr/bin/bash   
   
install_fedora_lact(){
    sudo dnf copr enable -y ilyaz/LACT
    sudo dnf install -y lact
    sudo systemctl enable --now lactd

}

install_opensuse_lact(){
    sudo zypper -n install dbus-1-daemon
    flatpak install -y flathub io.github.ilya_zlobintsev.LACT

}
if [ "$1" == "fedora" ]
then
    install_fedora_lact
elif [ "$1" == "opensuse" ]
then
    install_opensuse_lact
else
    echo "error"
fi