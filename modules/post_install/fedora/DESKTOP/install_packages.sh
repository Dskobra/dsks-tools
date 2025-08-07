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
curl -L -o proton-mail.rpm http://192.168.50.101/downloads/ProtonMail-desktop-beta.rpm
curl -L -o proton-pass.rpm http://192.168.50.101/downloads/ProtonPass.rpm
curl -L -o proton-authenticator.rpm http://192.168.50.101/downloads/ProtonAuthenticator-1.0.0-1.x86_64.rpm

sudo dnf install -y *.rpm
##########----------packages----------##########

hardware(){
    sudo dnf install -y openrgb
    sudo dnf install -y cpu-x
        sudo dnf copr enable -y ilyaz/LACT
        sudo dnf install -y lact
        sudo systemctl enable --now lactd
        sudo dnf install -y akmod-v4l2loopback v4l2loopback
         flatpak install --user -y flathub io.github.arunsivaramanneo.GPUViewer
}

kde(){
    sudo dnf install -y k3b
    sudo dnf install -y kate kate-plugins
    sudo dnf install -y isoimagewriter
    sudo dnf install -y kleopatra
}

internet(){
    flatpak install --user -y flathub com.brave.Browser
            flatpak install --user -y flathub org.mozilla.firefox
        sudo dnf remove -y firefox firefox-langpacks
                cd /opt/apps/temp/
        wget https://mega.nz/linux/repo/Fedora_42/x86_64/megasync-Fedora_42.x86_64.rpm && sudo dnf install -y "$PWD/megasync-Fedora_42.x86_64.rpm"
        rm megasync-Fedora_42.x86_64.rpm
        sudo dnf install -y remmina
}

multimedia(){
    flatpak install --user -y flathub org.videolan.VLC
    sudo dnf remove -y vlc
    flatpak install --user -y flathub com.obsproject.Studio
     sudo dnf install -y xfburn
     flatpak install --user -y flathub org.openshot.OpenShot
}

gaming(){
    flatpak install --user -y flathub info.cemu.Cemu
    flatpak install --user -y flathub com.discordapp.Discord
    flatpak install --user -y flathub org.DolphinEmu.dolphin-emu

    flatpak install --user -y flathub com.vysp3r.ProtonPlus
flatpak install --user -y flathub com.github.Matoking.protontricks
sudo dnf install -y steam-devices
sudo dnf install -y gamemode.x86_64 gamemode.i686
sudo dnf install -y goverlay
sudo dnf mark user -y gamemode.x86_64
sudo dnf mark user -y gamemode.i686
sudo dnf mark user -y steam-devices
flatpak install --user -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08

        flatpak install --user -y flathub net.lutris.Lutris
        flatpak override net.lutris.Lutris --user --filesystem=xdg-config/MangoHud:ro

                flatpak install --user -y flathub com.valvesoftware.Steam
        flatpak override com.valvesoftware.Steam  --user --filesystem=xdg-config/MangoHud:ro
        flatpak install --user -y flathub dev.goats.xivlauncher
}


dev(){
    sudo dnf install -y vim-enhanced
    sudo dnf install -y python3-idle python3-devel
                sudo dnf install -y toolbox distrobox docker-compose-switch
            flatpak install --user -y flathub io.podman_desktop.PodmanDesktop
            sudo dnf install -y git git-gui gh git-cola

                        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
            source ~/.bashrc
            nvm install lts/*

            sudo dnf install -y libvirt-daemon-config-network libvirt-daemon-kvm\
 qemu-kvm virt-install virt-manager virt-viewer
sudo usermod -aG libvirt "$USER"
xdg-open "https://github.com/virtio-win/virtio-win-pkg-scripts/blob/master/README.md"
}

extras(){
    flatpak install --user -y flathub org.qownnotes.QOwnNotes
    flatpak install --user -y flathub io.missioncenter.MissionCenter
    flatpak install --user -y flathub it.mijorus.gearlever
    flatpak install --user -y flathub org.gtkhash.gtkhash
    flatpak install --user -y flathub org.raspberrypi.rpi-imager
            flatpak install --user -y flathub org.libreoffice.LibreOffice
        sudo dnf remove -y libreoffice*
}
