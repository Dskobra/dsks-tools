#!/usr/bin/bash
install_packages(){
    cd "$TOOLS_FOLDER/temp" || exit
    sudo dnf install -y akmod-nvidia nvidia-settings xorg-x11-drv-nvidia-cuda
    sudo sh -c 'echo "%_with_kmod_nvidia_open 1" > /etc/rpm/macros.nvidia-kmod'
    sudo dnf install -y rpmfusion-nonfree-release-tainted
    sudo dnf install -y akmod-nvidia-open
    sudo akmods --rebuild --force
    sudo dracut --regenerate-all --force
}

"$TOOLS_FOLDER"/modules/post_install/fedora/shared/install_packages.sh
install_packages
zenity --warning --text="Reminder to restart terminal so it sees nodejs to install bash lsp"