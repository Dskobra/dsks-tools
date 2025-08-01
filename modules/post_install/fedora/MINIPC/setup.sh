#!/usr/bin/bash
##########----------packages----------##########
sudo dnf install -y dnfdragora cockpit cockpit-composer \
cockpit-bridge cockpit-doc cockpit-kdump  cockpit-files \
cockpit-networkmanager cockpit-ws-selinux cockpit-ws cockpit-system \
cockpit-storaged cockpit-sosreport cockpit-session-recording cockpit-selinux \
cockpit-packagekit clamav clamav-update clamd firewall-applet \
gnome-extensions-app gnome-shell-extension-appindicator gnome-tweaks dconf-editor
##########----------packages----------##########

##########----------hardware----------##########
"$TOOLS_FOLDER"/modules/post_install/minipc/hardware.sh

##########----------system----------##########
"$TOOLS_FOLDER"/modules/post_install/clamd.sh
hostnamectl set-hostname MINIPC

sudo sed -i '/SELINUX=enforcing/c SELINUX=permissive' /etc/selinux/config
sudo firewall-cmd --set-default-zone=home
sudo firewall-cmd --permanent --add-service=cockpit
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=rdp
sudo firewall-cmd --set-log-denied=all
sudo firewall-cmd --reload
sudo systemctl enable --now sshd
sudo systemctl enable --now cockpit.socket
sudo systemctl enable --now httpd

sudo cp /usr/lib/systemd/zram-generator.conf /usr/lib/systemd/zram-generator.conf.bak
sudo sed -i '/zram-size = min(ram, 8192)/c zram-size = min(ram, 16500)' /usr/lib/systemd/zram-generator.conf
sudo cp "$TOOLS_FOLDER"/modules/configs/index.html /var/www/html
sudo cp "$TOOLS_FOLDER"/modules/configs/web.conf /etc/httpd/conf.d/
sudo mkdir /var/www/html/downloads
sudo chmod 755 -R /var/www/html
sudo chown -R apache:apache /var/www/html
sudo systemctl restart httpd
# prevent pc from going to sleep when logged out
sudo -u gdm dbus-run-session gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
##########----------system----------##########

