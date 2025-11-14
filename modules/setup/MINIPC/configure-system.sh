#!/usr/bin/bash
configure_fedora_grub(){
    #sudo sed -i '/GRUB_CMDLINE_LINUX="rhgb quiet"/c GRUB_CMDLINE_LINUX="amd_iommu=on iommu=pt amdgpu.ppfeaturemask=0xffffffff crashkernel=512M rhgb quiet"' /etc/default/grub
    #sudo grubby --args="amd_iommu=on iommu=pt amdgpu.ppfeaturemask=0xffffffff crashkernel=512M rhgb quiet" --update-kernel=ALL
    sudo cp /etc/default/grub /etc/default/grub-og.bak
    sudo cp "$TOOLS_FOLDER"/modules/setup/MINIPC/grub-fedora-minipc /etc/default/grub
    sudo chown root:root /etc/default/grub
    sudo grub2-mkconfig -o /etc/grub2.cfg
}

configure_system(){
    hostnamectl set-hostname MINIPC

    sudo firewall-cmd --permanent --add-service=http
    sudo firewall-cmd --permanent --add-service=rdp
    sudo firewall-cmd --set-log-denied=all
    sudo firewall-cmd --reload
    sudo systemctl enable --now httpd

    sudo cp "$TOOLS_FOLDER"/modules/configs/index.html /var/www/html
    sudo cp "$TOOLS_FOLDER"/modules/configs/web.conf /etc/httpd/conf.d/
    sudo mkdir /var/www/html/downloads
    sudo chmod 755 -R /var/www/html
    sudo chown -R apache:apache /var/www/html
    sudo systemctl restart httpd
    # prevent pc from going to sleep when logged out
    sudo -u gdm dbus-run-session gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
}

if [ "$1" == "fedora" ]
then
    configure_fedora_grub
    configure_system
elif [ "$1" == "opensuse" ]
then
    configure_system
else
    echo "error"
fi