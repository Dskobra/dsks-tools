#!/usr/bin/bash

##########----------packages----------##########
cd "$TOOLS_FOLDER"/temp || exit
sudo rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo rpm-ostree apply-live

wget https://copr.fedorainfracloud.org/coprs/ilyaz/LACT/repo/fedora-42/ilyaz-LACT-fedora-42.repo
sudo rpm-ostree install --allow-inactive zenity openrgb cpu-x lact remmina k3b kate kate-plugins kleopatra xfburn steam-devices \
gamemode.x86_64 gamemode.i686 goverlay vim-enhanced distrobox git git-gui gh git-cola libvirt-daemon-config-network virt-manager \
dnfdragora driverctl ShellCheck clamav clamav-update clamd firewall-applet

## install flatpaks
flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install --user -y flathub com.github.tchx84.Flatseal io.github.arunsivaramanneo.GPUViewer com.brave.Browser \
org.mozilla.firefox org.videolan.VLC com.obsproject.Studio org.openshot.OpenShot info.cemu.Cemu com.discordapp.Discord \
org.DolphinEmu.dolphin-emu com.vysp3r.ProtonPlus  com.github.Matoking.protontricks net.lutris.Lutris com.valvesoftware.Steam \
dev.goats.xivlauncher io.podman_desktop.PodmanDesktop org.qownnotes.QOwnNotes io.missioncenter.MissionCenter it.mijorus.gearlever \
org.gtkhash.gtkhash org.raspberrypi.rpi-imager org.libreoffice.LibreOffice runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08

# install nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
source ~/.bashrc
nvm install lts/*

# install megasync
mkdir "$TOOLS_FOLDER/temp/"
cd "$TOOLS_FOLDER/temp" || exit
wget https://mega.nz/linux/repo/Fedora_42/x86_64/megasync-Fedora_42.x86_64.rpm && sudo rpm-ostree install "$PWD/megasync-Fedora_42.x86_64.rpm"
rm megasync-Fedora_42.x86_64.rpm

# install from local web server
curl -L -o dolphin-megasync.rpm http://192.168.50.101/downloads/dolphin-megasync-5.4.0-1.1.x86_64.rpm
curl -L -o ocs-url.rpm http://192.168.50.101/downloads/ocs-url-3.1.0-1.fc20.x86_64.rpm
curl -L -o proton-mail.rpm http://192.168.50.101/downloads/ProtonMail-desktop-beta.rpm
curl -L -o proton-pass.rpm http://192.168.50.101/downloads/ProtonPass.rpm
curl -L -o proton-authenticator.rpm http://192.168.50.101/downloads/ProtonAuthenticator-1.0.0-1.x86_64.rpm

sudo rpm-ostree install -y *.rpm
##########----------packages----------##########
