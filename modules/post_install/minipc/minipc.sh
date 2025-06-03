#!/usr/bin/bash
##########----------packages----------##########
sudo dnf install -y dnfdragora cockpit cockpit-composer \
cockpit-bridge cockpit-doc cockpit-kdump  cockpit-files \
cockpit-networkmanager cockpit-ws-selinux cockpit-ws cockpit-system \
cockpit-storaged cockpit-sosreport cockpit-session-recording cockpit-selinux \
cockpit-packagekit clamav clamav-update clamd firewall-applet \
gnome-extension-app gnome-shell-extension-appindicator gnome-tweaks dconf-editor
##########----------packages----------##########

##########----------hardware----------##########
"$TOOLS_FOLDER"/modules/post_install/laptop/hardware.sh

##########----------system----------##########
"$TOOLS_FOLDER"/modules/post_install/clamd.sh
#hostnamectl set-hostname MINIPC
hostnamectl set-hostname test
sudo sed -i '/SELINUX=enforcing/c SELINUX=permissive' /etc/selinux/config
sudo firewall-cmd --set-default-zone=home
sudo firewall-cmd --permanent --add-service=cockpit
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --set-log-denied=all
sudo firewall-cmd --reload
sudo systemctl enable --now sshd
sudo systemctl enable --now cockpit.socket
sudo systemctl enable httpd

sudo cp /usr/lib/systemd/zram-generator.conf zram-generator.conf.bak
sudo sed -i '/zram-size = min(ram, 8192)/c zram-size = min(ram, 16500)' /usr/lib/systemd/zram-generator.conf
##########----------system----------##########
