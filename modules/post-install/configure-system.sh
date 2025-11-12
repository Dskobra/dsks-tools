#!/usr/bin/bash
################################
### section for fedora /w dnf
################################
configure_zram(){
    cd "$TOOLS_FOLDER"/modules/configs/ || exit
    sudo cp zram-generator.conf /usr/lib/systemd/zram-generator.conf
    sudo chown root:root /usr/lib/systemd/zram-generator.conf
}

################################
### end section
################################

################################
### section for fedora /w ostree
################################

configure_fedora_ostree(){
    # set zram swap from default 8gb to 16gb
    cd "$TOOLS_FOLDER"/temp || exit
    touch zram-generator.conf
    echo "[zram0]" >> zram-generator.conf
    echo "zram-size = min(ram, 16500)" >> zram-generator.conf
    sudo mv zram-generator.conf /etc/systemd/zram-generator.conf

    # set time grub takes before auto selecting boot entry
    echo "set timeout=12" | sudo tee /boot/grub2/user.cfg > /dev/null

    # https://docs.fedoraproject.org/en-US/fedora-silverblue/troubleshooting/#_unable_to_add_user_to_group
    grep -E '^libvirt:' /usr/lib/group | sudo tee -a /etc/group
}

hide_firefox_from_ostree_desktop(){
    # hides firefox from gnome/kde
    sudo mkdir -p /usr/local/share/applications/
    sudo cp /usr/share/applications/org.mozilla.firefox.desktop /usr/local/share/applications/
    sudo sed -i "2a\\NotShowIn=GNOME;KDE" /usr/local/share/applications/org.mozilla.firefox.desktop
    sudo update-desktop-database /usr/local/share/applications/
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
    cp "$TOOLS_FOLDER/modules/configs/shortcuts/XIVFPS.desktop" "$HOME"/.local/share/applications/XIVFPS.desktop
    npm i -g bash-language-server
}

if [ "$1" == "fedora-dnf" ]
then
    configure_fedora_dnf_zram
    configure_system
    sudo systemctl enable --now clamav-freshclam.service clamd@scan.service
    sudo grub2-editenv - unset menu_auto_hide
    sudo dracut --regenerate-all --force    # rebuild initramfs for all installed kernels
elif [ "$1" == "fedora-ostree" ]
then
    configure_ostree_system
    configure_system
    sudo systemctl enable --now clamav-freshclam.service clamd@scan.service
    sudo grub2-editenv - unset menu_auto_hide
elif [ "$1" == "opensuse" ]
then
    configure_system
    configure_zram
    sudo systemctl enable --now clamd
else
    echo "error"
fi
