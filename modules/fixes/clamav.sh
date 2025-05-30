#!/usr/bin/bash

clamav(){
    # https://discussion.fedoraproject.org/t/use-clamdscan-on-workstation-f38/96864/3
    # note not sure why setroubleshoot package isnt preinstalled in fedora 41 kde spin.
    # fedora 40 was preinstalled
    sudo dnf install -y clamav clamav-update clamd #setroubleshoot
    sudo sed -i -e "/^#*LocalSocket\s/s/^#//" /etc/clamd.d/scan.conf
    sudo freshclam
    sudo systemctl --now enable clamav-freshclam.service clamd@scan.service
    sudo semanage boolean -m -1 antivirus_can_scan_system
}

clamav
