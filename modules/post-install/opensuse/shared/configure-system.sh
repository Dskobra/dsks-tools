#!/usr/bin/bash
configure_security(){
    sudo sed -i -e "/^#*LocalSocket\s/s/^#//" /etc/clamd.d/scan.conf
    sudo freshclam
    sudo systemctl enable --now clamd
    sudo semanage boolean -m -1 antivirus_can_scan_system

    sudo firewall-cmd --set-default-zone=home
    sudo firewall-cmd --permanent --add-service=cockpit
    sudo firewall-cmd --permanent --add-service=kdeconnect
    sudo firewall-cmd --set-log-denied=all
    sudo firewall-cmd --reload
    sudo systemctl enable --now sshd
}

configure_system_settings(){
    # set zram swap from default 8gb to 16gb
    sudo touch /usr/lib/systemd/zram-generator.conf
    sudo chown root:root /usr/lib/systemd/zram-generator.conf
    echo "[zram0]" | sudo tee -a /usr/lib/systemd/zram-generator.conf > /dev/null
    echo "zram-size = min(ram, 16500)" | sudo tee -a /usr/lib/systemd/zram-generator.conf > /dev/null
    sudo usermod -aG libvirt "$USER"
    #sudo modprobe ntsync
    #sudo touch /etc/modules-load.d/ntsync.conf
    #echo "ntsync"  | sudo tee  /etc/modules-load.d/ntsync.conf > /dev/null
}


configure_security
configure_system_settings
