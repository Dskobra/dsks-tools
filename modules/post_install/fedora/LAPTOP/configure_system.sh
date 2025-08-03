#!/usr/bin/bash
configure_clamd(){
    sudo sed -i -e "/^#*LocalSocket\s/s/^#//" /etc/clamd.d/scan.conf
    sudo freshclam
    sudo systemctl enable --now clamav-freshclam.service clamd@scan.service
    sudo semanage boolean -m -1 antivirus_can_scan_system
}
##########----------configure system----------##########
configure_clamd
sudo sed -i '/SELINUX=enforcing/c SELINUX=permissive' /etc/selinux/config
sudo firewall-cmd --set-default-zone=home
sudo firewall-cmd --permanent --add-service=cockpit
sudo firewall-cmd --permanent --add-service=kdeconnect
sudo firewall-cmd --set-log-denied=all
sudo firewall-cmd --reload
sudo systemctl enable --now sshd
sudo systemctl enable --now cockpit.socket

sudo cp /usr/lib/systemd/zram-generator.conf /usr/lib/systemd/zram-generator.conf.bak
sudo sed -i '/zram-size = min(ram, 8192)/c zram-size = min(ram, 16500)' /usr/lib/systemd/zram-generator.conf
# Default Fedora hides the grub menu. I prefer it visible (like having the option when testing new kernels, nvidia driver breaks
# or just cause)

sudo grub2-editenv - unset menu_auto_hide
#sudo modprobe ntsync
#sudo touch /etc/modules-load.d/ntsync.conf
#echo "ntsync"  | sudo tee -a /etc/modules-load.d/ntsync.conf > /dev/null
##########----------configure system----------##########
