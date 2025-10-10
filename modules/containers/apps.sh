#!/usr/bin/bash

### Create a container for apps that don't require codecs
install_packages(){
    sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf install -y clamav clamav-update vim-enhanced wget

    wget https://mega.nz/linux/repo/Fedora_42/x86_64/megasync-Fedora_42.x86_64.rpm && sudo dnf install -y "$PWD/megasync-Fedora_42.x86_64.rpm"

    if [ "$DESKTOP_ENV" == "KDE" ]
    then
        sudo dnf install -y k3b
        distrobox-export --app k3b
        curl -L -o dolphin-megasync.rpm https://mega.nz/linux/repo/Fedora_42/x86_64/dolphin-megasync-5.4.0-2.1.x86_64.rpm
    elif [ "$DESKTOP_ENV" == "GNOME" ]
    then
        sudo dnf install -y  xfburn xarchiver
        distrobox-export --app xfburn
        distrobox-export --app xarchiver
        curl -L -o nautilus-megasync.rpm https://mega.nz/linux/repo/Fedora_42/x86_64/nautilus-megasync-5.4.0-1.1.x86_64.rpm
    else
        echo "$DESKTOP_ENV is not supported."
    fi

    curl -L -o proton-mail.rpm https://proton.me/download/mail/linux/1.9.0/ProtonMail-desktop-beta.rpm
    curl -L -o proton-pass.rpm https://proton.me/download/pass/linux/proton-pass-1.32.3-1.x86_64.rpm
    curl -L -o proton-authenticator.rpm https://proton.me/download/authenticator/linux/ProtonAuthenticator-1.0.0-1.x86_64.rpm

    sudo dnf install -y *.rpm
    rm *.rpm
    

    #
    distrobox-export --bin /usr/bin/vim

    # cloud apps
    distrobox-export --app megasync
    distrobox-export --app proton-pass
    distrobox-export --app proton-mail
    distrobox-export --app proton-authenticator
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