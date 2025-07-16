#!/usr/bin/bash
##########----------install packages----------##########
sudo zypper -n install  cockpit cockpit-bridge \
cockpit-doc cockpit-kdump cockpit-networkmanager cockpit-ws-selinux \
cockpit-ws cockpit-system cockpit-storaged cockpit-selinux \
cockpit-podman cockpit-packagekit cockpit-machines ShellCheck \
clamav firewall-applet i2c-tools python313-python-lsp-server \
systemd-zram-service
npm i -g bash-language-server

# install from local web server
mkdir "$TOOLS_FOLDER/temp/"
cd "$TOOLS_FOLDER/temp" || exit

curl -L -o ocs-url.rpm http://192.168.50.101/downloads/ocs-url-3.1.0-1.x86_64.rpm
curl -L -o protonmail.rpm http://192.168.50.101/downloads/ProtonMail-desktop-beta.rpm
curl -L -o proton-pass.rpm http://192.168.50.101/downloads/ProtonPass.rpm

sudo zypper -n --no-gpg-checks install  *.rpm
##########----------install packages----------##########
