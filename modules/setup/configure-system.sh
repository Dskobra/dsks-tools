#!/usr/bin/bash
################################
### section for opensuse
################################
configure_zram(){
    cd "$TOOLS_FOLDER"/modules/configs/ || exit
    sudo cp zram-generator.conf /usr/lib/systemd/zram-generator.conf
    sudo chown root:root /usr/lib/systemd/zram-generator.conf
}

configure_opensuse_root_editor(){
    # distros like fedora if you edit a system config with kate/kwrite
    # it asks for password in order to save. opensuse has this patched 
    # out. So use a custom shortcut that calls kwrite (kate doesnt work)
    # with kdesu

    # weird bug if you open kwrite after putting your password in with 
    # kdesu and no config is present it gets created as root (not writable)
    # when you close kwrite. If you hit ignore on password entry it gets created
    # as your user if no file is present.
    touch "$HOME"/.config/kwriterc  
    cp "$TOOLS_FOLDER"/modules/configs/kwrite-su.desktop "$HOME"/.local/share/applications/kwrite-su.desktop


}
################################
### end section
################################

configure_system(){
    sudo sed -i '/SELINUX=enforcing/c SELINUX=permissive' /etc/selinux/config
    sudo firewall-cmd --set-default-zone=home
    sudo firewall-cmd --permanent --add-service=kdeconnect
    sudo firewall-cmd --permanent --add-service=cockpit
    sudo firewall-cmd --zone=home --add-port=1716-1764/tcp
    sudo firewall-cmd --zone=home --add-port=1716-1764/udp
    sudo firewall-cmd --set-log-denied=all
    sudo firewall-cmd --reload
    sudo systemctl enable --now sshd
    sudo systemctl enable --now libvirtd
    sudo systemctl enable --now cockpit.socket
    
    # setup clamav daemon
    sudo sed -i -e "/^#*LocalSocket\s/s/^#//" /etc/clamd.d/scan.conf
    sudo freshclam
    sudo semanage boolean -m -1 antivirus_can_scan_system

    # Load ntsync kernel mod and set it to auto load.
    sudo modprobe ntsync
    sudo touch /etc/modules-load.d/ntsync.conf
    echo "ntsync"  | sudo tee  /etc/modules-load.d/ntsync.conf > /dev/null

    # OpenRGB needs a a couple kernel mods loaded
    # for smbus access. So make sure they are
    # automatically loaded on boot
    sudo modprobe i2c-dev
    sudo modprobe i2c-piix4
    sudo touch /etc/modules-load.d/i2c.conf
    sudo sh -c 'echo "i2c-dev" >> /etc/modules-load.d/i2c.conf'
    sudo sh -c 'echo "i2c-piix4" >> /etc/modules-load.d/i2c.conf'
    sudo i2cdetect -l
    
    # set drivers for passthrough
    echo 'add_driver+=" vfio vfio_iommu_type1 vfio_pci vfio_virqfd "' | sudo tee /etc/dracut.conf.d/local.conf > /dev/null
    sudo chown root:root "/etc/dracut.conf.d/local.conf"

    sudo usermod -aG libvirt "$USER"

    mkdir "$HOME"/.local/share/applications/
    npm i -g bash-language-server
}

if [ "$1" == "fedora" ]
then
    configure_fedora_dnf_zram
    configure_system
    sudo systemctl enable --now clamav-freshclam.service clamd@scan.service
    sudo grub2-editenv - unset menu_auto_hide
    sudo dracut --regenerate-all --force    # rebuild initramfs for all installed kernels
elif [ "$1" == "opensuse" ]
then
    configure_system
    configure_zram
    sudo systemctl enable --now clamd
    kdesu yast2 bootloader
    #sudo sdbootutil set-timeout -- 12
else
    echo "error"
fi
