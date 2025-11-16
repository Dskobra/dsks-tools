#!/usr/bin/bash
configure_fedora_grub(){
    #sudo sed -i '/GRUB_CMDLINE_LINUX="rhgb quiet"/c GRUB_CMDLINE_LINUX="amd_iommu=on iommu=pt amdgpu.ppfeaturemask=0xffffffff crashkernel=512M rhgb quiet"' /etc/default/grub
    #sudo grubby --args="amd_iommu=on iommu=pt amdgpu.ppfeaturemask=0xffffffff crashkernel=512M rhgb quiet" --update-kernel=ALL
    sudo cp /etc/default/grub /etc/default/grub-og.bak
    sudo cp "$TOOLS_FOLDER"/modules/setup/MINIPC/grub-fedora-minipc /etc/default/grub
    sudo chown root:root /etc/default/grub
    sudo grub2-mkconfig -o /etc/grub2.cfg
}

configure_fedora_system(){
    hostnamectl set-hostname MINIPC

    sudo firewall-cmd --permanent --add-service=http
    sudo firewall-cmd --permanent --add-service=rdp
    sudo firewall-cmd --set-log-denied=all
    sudo firewall-cmd --reload
    sudo systemctl enable --now httpd

    sudo cp "$TOOLS_FOLDER"/modules/configs/index.html /var/www/html
    sudo cp "$TOOLS_FOLDER"/modules/configs/fedora-web.conf /etc/httpd/conf.d/web.conf
    sudo mkdir /var/www/html/downloads
    sudo chmod 755 -R /var/www/html
    sudo chown -R apache:apache /var/www/html
    sudo systemctl restart httpd
    # prevent pc from going to sleep when logged out
    sudo -u gdm dbus-run-session gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
}

configure_opensuse_system(){
    hostnamectl set-hostname MINIPC
    sudo firewall-cmd --permanent --add-service=rdp
    sudo firewall-cmd --permanent --add-service=http
    sudo firewall-cmd --permanent --add-service=https
    sudo firewall-cmd --set-log-denied=all
    sudo firewall-cmd --reload
    sudo systemctl enable --now apache2

    sudo mkdir /srv/www/htdocs/downloads
    sudo cp "$TOOLS_FOLDER"/modules/configs/index.html /srv/www/htdocs
    sudo cp "$TOOLS_FOLDER"/modules/configs/opensuse-web.conf /etc/apache2/conf.d/web.conf
    sudo chmod 755 -R /srv/www/htdocs
    sudo chown -R wwwrun:www /srv/www/htdocs
    sudo systemctl restart apache2

    if [ "$XDG_CURRENT_DESKTOP" == "KDE" ]
    then
        echo ""
    elif [ "$XDG_CURRENT_DESKTOP" == "GNOME" ]
    then
        # prevent pc from going to sleep when logged out
        sudo -u gdm dbus-run-session gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
    else
        echo "$XDG_CURRENT_DESKTOP is not supported."
    fi

}
configure_gdm(){
    if [ "$XDG_CURRENT_DESKTOP" == "KDE" ]
    then
        echo ""
    elif [ "$XDG_CURRENT_DESKTOP" == "GNOME" ]
    then
        # prevent pc from going to sleep when logged out on gnome
        sudo -u gdm dbus-run-session gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
    else
        echo "$XDG_CURRENT_DESKTOP is not supported."
    fi

}
if [ "$1" == "fedora" ]
then
    configure_fedora_grub
    configure_fedora_system
    configure_gdm
elif [ "$1" == "opensuse" ]
then
    configure_opensuse_system
    configure_gdm
else
    echo "error"
fi