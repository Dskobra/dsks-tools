#!/usr/bin/bash

##########----------packages----------##########
sudo dnf install -y dnfdragora driverctl cockpit cockpit-composer \
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
curl -L -o proton-pass.rpm http://192.168.50.101/downloads/proton-pass-1.31.5-1.x86_64.rpm

sudo dnf install -y *.rpm
##########----------packages----------##########
