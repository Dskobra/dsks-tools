#!/usr/bin/bash
create_zram_config(){
    sudo touch /usr/lib/systemd/zram-generator.conf
    sudo chown root:root /usr/lib/systemd/zram-generator.conf
    echo "[zram0]" | sudo tee -a /usr/lib/systemd/zram-generator.conf > /dev/null
    echo "zram-size = min(ram, 16500)" | sudo tee -a /usr/lib/systemd/zram-generator.conf > /dev/null


}

configure_clamd(){
    sudo freshclam
    sudo semanage boolean -m -1 antivirus_can_scan_system
    sudo systemctl --now enable clamd freshclam
}
##########----------configure system----------##########
create_zram_config
configure_clamd
sudo sed -i '/SELINUX=enforcing/c SELINUX=permissive' /etc/selinux/config
sudo firewall-cmd --set-default-zone=home
sudo firewall-cmd --permanent --add-service=cockpit
sudo firewall-cmd --permanent --add-service=kdeconnect
sudo firewall-cmd --set-log-denied=all
sudo firewall-cmd --reload
sudo systemctl enable --now sshd
sudo systemctl enable --now cockpit.socket


#sudo modprobe ntsync
#sudo touch /etc/modules-load.d/ntsync.conf
#echo "ntsync"  | sudo tee -a /etc/modules-load.d/ntsync.conf > /dev/null
##########----------configure system----------##########
