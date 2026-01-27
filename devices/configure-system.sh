#!/usr/bin/bash
################################
### section for opensuse
################################
configure_opensuse(){
    # openSUSE patches out calling kdesu to save files as root.
    # Workaround create shortcut for kwrite (kate doesnt work) 
    # called by kdesu.
    
    # weird bug when saving if using kwrite with kdesu and kwriterc doesnt exist
    # it will get set as root when clicking ok. Clicking cancel it'll be set
    # as user.
    touch "$HOME"/.config/kwriterc
    mkdir "$HOME"/.local/share/applications
    cp "$TOOLS_FOLDER"/modules/configs/kwrite-su.desktop "$HOME"/.local/share/applications/kwrite-su.desktop

    sudo systemctl enable --now clamd
    sudo sdbootutil set-timeout -- 12

    cd "$TOOLS_FOLDER"/modules/configs/ || exit
    sudo cp zram-generator.conf /usr/lib/systemd/zram-generator.conf
    sudo chown root:root /usr/lib/systemd/zram-generator.conf


}

build_cockpit_files(){
    cd "$TOOLS_FOLDER"/temp || exit
    git clone https://github.com/cockpit-project/cockpit-files.git
    cd "cockpit-files" || exit
    make
    sudo make install
    rm -r -f "$TOOLS_FOLDER"/temp/cockpit-files
}
################################
### end section
################################
configure_fedora(){
    sudo sed -i -e "/^#*LocalSocket\s/s/^#//" /etc/clamd.d/scan.conf
    sudo systemctl enable --now clamav-freshclam.service clamd@scan.service
    sudo grub2-editenv - unset menu_auto_hide
}

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
    sudo systemctl enable --now virtnetworkd
    sudo systemctl enable --now cockpit.socket

    sudo virsh net-start default
    sudo virsh net-autostart default
    
    # setup clamav daemon
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
    sudo dracut --regenerate-all --force    # rebuild initramfs for all installed kernels
}

if [ "$1" == "fedora" ]
then
    configure_fedora
    configure_system
elif [ "$1" == "opensuse" ]
then
    configure_opensuse
    configure_system
    build_cockpit_files
else
    echo "error"
fi
