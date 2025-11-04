#!/usr/bin/bash
### shared packages between my devices.
install_packages(){
    cd "$TOOLS_FOLDER/temp" || exit
    sudo zypper -n install --auto-agree-with-licenses setroubleshoot-server git git-gui gh git-cola python313-idle \
    patterns-containers-container_runtime distrobox OpenRGB cpu-x remmina steam steam-devices gamemode goverlay \
    virt-manager docker-compose-switch ShellCheck clamav firewall-applet i2c-tools python313-python-lsp-server \
    systemd-zram-service zram-generator v4l2loopback-kmp-default v4l2loopback-kmp-longterm v4l2loopback-autoload \
    python313-devel opi vlc discord kdump

    sudo opi -n megasync
    sudo opi -n brave

    if [ "$DESKTOP_TYPE" == "KDE" ]
    then
        sudo zypper -n install k3b kate kate-plugins kdiff3 kleopatra
    elif [ "$DESKTOP_TYPE" == "GNOME" ]
    then
        sudo zypper -n install gnome-tweaks dconf-editor file-roller xfburn snapshot yaru-icon-theme
    else
        echo "$DESKTOP_TYPE is not supported."
    fi
    curl -L -o proton-mail.rpm https://proton.me/download/mail/linux/1.9.0/ProtonMail-desktop-beta.rpm
    curl -L -o proton-pass.rpm https://proton.me/download/pass/linux/proton-pass-1.32.3-1.x86_64.rpm
    curl -L -o proton-authenticator.rpm https://proton.me/download/authenticator/linux/ProtonAuthenticator-1.0.0-1.x86_64.rpm


    sudo zypper -n --no-gpg-checks install  *.rpm
    rm *.rpm
}

install_flatpaks(){
    flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo

    # most important
    flatpak install --user -y flathub com.github.tchx84.Flatseal org.mozilla.firefox org.cockpit_project.CockpitClient

    # tools
    flatpak install --user -y flathub  io.missioncenter.MissionCenter it.mijorus.gearlever io.github.arunsivaramanneo.GPUViewer \
    org.gtkhash.gtkhash com.vysp3r.ProtonPlus com.github.Matoking.protontricks app.devsuite.Ptyxis

    # entertainment
    flatpak install --user -y flathub net.lutris.Lutris info.cemu.Cemu org.DolphinEmu.dolphin-emu \
    dev.goats.xivlauncher com.pokemmo.PokeMMO runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08 \
    runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/24.08

    # misc
    flatpak install --user -y flathub org.raspberrypi.rpi-imager com.obsproject.Studio io.podman_desktop.PodmanDesktop \
    org.qownnotes.QOwnNotes

    if [ "$DESKTOP_TYPE" == "KDE" ]
    then
        echo ""
    elif [ "$DESKTOP_TYPE" == "GNOME" ]
    then
       flatpak install --user -y flathub com.mattjakeman.ExtensionManager org.kde.kleopatra
    else
        echo "$DESKTOP_TYPE is not supported."
    fi
}

cleanup(){
    sudo zypper -n rm lftp kmahjongg kmines kreversi ksudoku icewm icewm-config-upstream \
    yast2-firewall yast2-network yast2-country yast2-printer yast2-proxy yast2-scanner \
    yast2-services-manager xscreensaver xscreensaver-data gnome-mahjongg swell-foop \
    quadrapassel gnome-mines gnome-chess lightsoff gnome-sudoku cheese gnome-extensions \
    totem gnome-photos xterm yast2-kdump
}

DESKTOP_TYPE=$(echo $XDG_CURRENT_DESKTOP)
echo "Desktop is $DESKTOP_TYPE"
install_packages
install_flatpaks
cleanup


# install nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
source ~/.bashrc
nvm install lts/*
zenity --warning --text="Reminder to restart terminal so it sees nodejs to install bash lsp."

