#!/usr/bin/bash
"$TOOLS_FOLDER"/modules/post_install/fedora/shared/configure_system.sh
sudo systemctl enable --now lactd
# prevent gdm from going to sleep
sudo -u gdm dbus-run-session gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0