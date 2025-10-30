#!/usr/bin/bash

"$TOOLS_FOLDER"/modules/post-install/distro/shared/configure_system.sh
hostnamectl set-hostname MINIPC

sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=rdp
sudo firewall-cmd --set-log-denied=all
sudo firewall-cmd --reload
sudo systemctl enable --now httpd

sudo cp "$TOOLS_FOLDER"/modules/configs/index.html /var/www/html
sudo cp "$TOOLS_FOLDER"/modules/configs/web.conf /etc/httpd/conf.d/
sudo mkdir /var/www/html/downloads
sudo chmod 755 -R /var/www/html
sudo chown -R apache:apache /var/www/html
sudo systemctl restart httpd
# prevent pc from going to sleep when logged out
sudo -u gdm dbus-run-session gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
