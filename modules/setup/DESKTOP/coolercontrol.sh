#!/usr/bin/bash   
   
install_fedora_cooler_control(){
    sudo dnf copr enable -y codifryed/CoolerControl
    sudo dnf install -y coolercontrol
    sudo systemctl enable --now coolercontrold
}

install_opensuse_cooler_control(){
    sudo zypper addrepo https://download.opensuse.org/repositories/home:codifryed/openSUSE_Tumbleweed/home:codifryed.repo
    sudo zypper refresh
    sudo zypper -n install coolercontrol
    sudo systemctl enable --now coolercontrold

}
if [ "$1" == "fedora-dnf" ]
then
    install_fedora_cooler_control
elif [ "$1" == "opensuse" ]
then
    install_opensuse_cooler_control
else
    echo "error"
fi