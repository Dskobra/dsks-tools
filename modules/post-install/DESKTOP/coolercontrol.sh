#!/usr/bin/bash   
   
install_cooler_control_dnf(){
    sudo dnf copr enable -y codifryed/CoolerControl
    sudo dnf install -y coolercontrol
    sudo systemctl enable --now coolercontrold
}

install_cooler_control_ostree(){
    # Install the Copr repository manually for your base Fedora release version:
    wget https://copr.fedorainfracloud.org/coprs/codifryed/CoolerControl/repo/fedora-$(rpm -E %fedora)/codifryed-CoolerControl-fedora-$(rpm -E %fedora).repo
    sudo mv codifryed-CoolerControl-fedora-$(rpm -E %fedora).repo /etc/yum.repos.d/
    sudo rpm-ostree refresh-md
    sudo rpm-ostree install coolercontrol
    
}


if [ "$1" == "fedora-dnf" ]
then
    install_cooler_control_dnf
elif [ "$1" == "fedora-ostree" ]
then
    install_cooler_control_ostree
else
    echo "error"
fi