#!/usr/bin/bash
##########----------packages----------##########
sudo dnf install -y dnfdragora cockpit cockpit-composer \
cockpit-bridge cockpit-doc cockpit-image-builder cockpit-kdump  cockpit-files \
cockpit-networkmanager cockpit-ws-selinux cockpit-ws cockpit-system \
cockpit-storaged cockpit-sosreport cockpit-session-recording cockpit-selinux \
cockpit-podman cockpit-packagekit cockpit-machines Shellcheck python3-lsp-server \
clamav clamav-update clamd

# install from local web server
#cd ~/Drives/shared/packages || exit
#sudo rpm -i dolphin-megasync-*.x86_64.rpm
#sudo rpm -i ocs-url-*.x86_64.rpm
#sudo rpm -i ProtonMail-desktop-beta.rpm
#sudo rpm -i ProtonPass.rpm
#npm i -g bash-language-server

##########----------packages----------##########

##########----------hardware----------##########
"$TOOLS_FOLDER"/modules/post_install/laptop/hardware.sh

##########----------system----------##########
"$TOOLS_FOLDER"/modules/post_install/clamd.sh
sudo sed -i '/SELINUX=enforcing/c SELINUX=permissive' /etc/selinux/config
sudo firewall-cmd --permanent --set-default-zone=home
sudo firewall-cmd --permanent --add-service=cockpit
sudo firewall-cmd --permanent --add-service=kdeconnect
sudo firewall-cmd --set-log-denied=all
sudo fireall-cmd --reload
sudo systemctl enable --now sshd
sudo systemctl enable --now cockpit.socket

sudo cp /usr/lib/systemd/zram-generator.conf zram-generator.conf.bak
sudo sed -i '/zram-size = min(ram, 8192)/c zram-size = min(ram, 16500)' /usr/lib/systemd/zram-generator.conf
##########----------system----------##########

