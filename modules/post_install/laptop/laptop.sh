#!/usr/bin/bash
##########----------packages----------##########
sudo dnf install -y dnfdragora cockpit cockpit-composer \
cockpit-bridge cockpit-doc cockpit-image-builder cockpit-kdump  cockpit-files \
cockpit-networkmanager cockpit-ws-selinux cockpit-ws cockpit-system \
cockpit-storaged cockpit-sosreport cockpit-session-recording cockpit-selinux \
cockpit-podman cockpit-packagekit cockpit-machines ShellCheck python3-lsp-server \
clamav clamav-update clamd firewall-applet
npm i -g bash-language-server

# install from local web server
mkdir "$TOOLS_FOLDER/temp/"
cd "$TOOLS_FOLDER/temp" || exit

curl -L -o dolphin-megasync.rpm http://192.168.50.101/downloads/dolphin-megasync-5.4.0-1.1.x86_64.rpm
curl -L -o ocs-url.rpm http://192.168.50.101/downloads/ocs-url-3.1.0-1.fc20.x86_64.rpm
curl -L -o protonmail.rpm http://192.168.50.101/downloads/ProtonMail-desktop-beta.rpm
curl -L -o proton-pass.rpm http://192.168.50.101/downloads/proton-pass-1.31.4-1.x86_64.rpm

sudo rpm -i dolphin-megasync.rpm
sudo rpm -i ocs-url.rpm
sudo rpm -i protonmail.rpm
sudo rpm -i proton-pass.rpm
##########----------packages----------##########

##########----------hardware----------##########
"$TOOLS_FOLDER"/modules/post_install/laptop/hardware.sh

##########----------system----------##########
"$TOOLS_FOLDER"/modules/post_install/clamd.sh
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
##########----------system----------##########

