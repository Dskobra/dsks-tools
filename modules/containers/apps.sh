#!/usr/bin/bash

### Create a container for apps that don't require codecs
install_packages(){
    sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf install -y vim-enhanced wget

    curl -L -o proton-mail.rpm $PROTON_MAIL
    curl -L -o proton-pass.rpm $PROTON_PASS
    curl -L -o proton-authenticator.rpm $PROTON_AUTH

    sudo dnf install -y *.rpm
    rm *.rpm
    
    # cloud apps
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