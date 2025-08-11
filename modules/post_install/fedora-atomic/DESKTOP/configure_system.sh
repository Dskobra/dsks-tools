#!/usr/bin/bash
configure_clamd(){
    sudo sed -i -e "/^#*LocalSocket\s/s/^#//" /etc/clamd.d/scan.conf
    sudo freshclam
    sudo systemctl enable --now clamav-freshclam.service clamd@scan.service
    sudo semanage boolean -m -1 antivirus_can_scan_system
}

configure_zram(){
    cd "$TOOLS_FOLDER"/temp || exit
    touch zram-generator.conf
    echo "[zram0]" >> zram-generator.conf
    echo "zram-size = min(ram, 16500)" >> zram-generator.conf
    sudo mv zram-generator.conf /etc/systemd/zram-generator.conf
}

build_ossec(){
    cd "$TOOLS_FOLDER/temp" || exit
    curl -L -o ossec.tar.gz https://github.com/ossec/ossec-hids/archive/3.8.0.tar.gz
    tar -xvf ossec.tar.gz
    cd ossec-hids-3.8.0 || exit
    sudo ./install.sh
}
##########----------system----------##########
configure_clamd
build_ossec
sudo sed -i '/SELINUX=enforcing/c SELINUX=permissive' /etc/selinux/config
sudo firewall-cmd --set-default-zone=home
sudo firewall-cmd --permanent --add-service=cockpit
sudo firewall-cmd --permanent --add-service=kdeconnect
sudo firewall-cmd --set-log-denied=all
sudo firewall-cmd --reload
sudo systemctl enable --now sshd

# set zram swap from default 8gb to 16gb
configure_zram
# Default Fedora hides the grub menu. I prefer it visible (like having the option when testing new kernels, nvidia driver breaks
# or just cause)

sudo grub2-editenv - unset menu_auto_hide
# https://docs.fedoraproject.org/en-US/fedora-silverblue/troubleshooting/#_unable_to_add_user_to_group
grep -E '^libvirt:' /usr/lib/group | sudo tee -a /etc/group
sudo usermod -aG libvirt $USER
#sudo systemctl enable --now lactd
#sudo modprobe ntsync
#sudo touch /etc/modules-load.d/ntsync.conf
#echo "ntsync"  | sudo tee -a /etc/modules-load.d/ntsync.conf > /dev/null
##########----------system----------##########


