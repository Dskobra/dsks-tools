#!/usr/bin/bash

clamd(){
    # fedora 40 was preinstalled
    sudo dnf install -y clamav clamav-update clamd
    sudo sed -i -e "/^#*LocalSocket\s/s/^#//" /etc/clamd.d/scan.conf
    sudo freshclam
    sudo systemctl --now enable clamav-freshclam.service clamd@scan.service
    sudo semanage boolean -m -1 antivirus_can_scan_system
}

clamd
