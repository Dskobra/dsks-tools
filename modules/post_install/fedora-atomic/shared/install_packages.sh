#!/usr/bin/bash
install_packages(){
    sudo rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo rpm-ostree apply-live

    sudo rpm-ostree install vim-enhanced  virt-manager openrgb steam-devices goverlay clamav clamav-update clamd \
    firewall-applet zenity i2c-tools

    # dev tools are sometimes broken due to mismatches on mirrors. Might have to wait several hours.
    sudo rpm-ostree install gamemode.i686

    # install megasync
    wget https://mega.nz/linux/repo/Fedora_42/x86_64/megasync-Fedora_42.x86_64.rpm
    if [ "$DESKTOP_ENV" == "KDE" ]
    then
        sudo rpm-ostree install k3b
        curl -L -o dolphin-megasync.rpm https://mega.nz/linux/repo/Fedora_42/x86_64/dolphin-megasync-5.4.0-1.1.x86_64.rpm
    elif [ "$DESKTOP_ENV" == "GNOME" ]
    then
        sudo rpm-ostree install gnome-shell-extension-appindicator gnome-tweaks dconf-editor file-roller xfburn
        curl -L -o nautilus-megasync.rpm https://mega.nz/linux/repo/Fedora_42/x86_64/nautilus-megasync-5.3.0-1.1.x86_64.rpm
    else
        echo "$DESKTOP_ENV is not supported."
    fi
    curl -L -o proton-mail.rpm https://proton.me/download/mail/linux/1.9.0/ProtonMail-desktop-beta.rpm
    curl -L -o proton-pass.rpm https://proton.me/download/pass/linux/proton-pass-1.32.3-1.x86_64.rpm
    curl -L -o proton-authenticator.rpm https://proton.me/download/authenticator/linux/ProtonAuthenticator-1.0.0-1.x86_64.rpm

    sudo rpm-ostree install *.rpm
    rm *.rpm
    sudo rpm-ostree apply-live

    # distrobox
    curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh
}

attempt_to_install_broken_apps(){

}

install_flatpaks(){
    flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo

    # most important
    flatpak install --user -y flathub com.github.tchx84.Flatseal com.brave.Browser org.mozilla.firefox org.cockpit_project.CockpitClient \
    com.discordapp.Discord

    # tools
    flatpak install --user -y flathub  io.missioncenter.MissionCenter it.mijorus.gearlever io.github.arunsivaramanneo.GPUViewer \
    org.gtkhash.gtkhash com.vysp3r.ProtonPlus com.github.Matoking.protontricks org.kde.isoimagewriter

    # entertainment
    flatpak install --user -y flathub net.lutris.Lutris com.valvesoftware.Steam info.cemu.Cemu org.DolphinEmu.dolphin-emu \
    dev.goats.xivlauncher com.pokemmo.PokeMMO runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08 \
    runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/24.08

    # misc
    flatpak install --user -y flathub org.raspberrypi.rpi-imager org.videolan.VLC com.obsproject.Studio org.openshot.OpenShot \
    io.podman_desktop.PodmanDesktop org.qownnotes.QOwnNotes

    if [ "$DESKTOP_ENV" == "KDE" ]
    then
        echo ""
    elif [ "$DESKTOP_ENV" == "GNOME" ]
    then
       flatpak install --user -y flathub com.mattjakeman.ExtensionManager org.gnome.baobab \
       org.gnome.font-viewer org.gnome.Loupe org.gnome.Papers
    else
        echo "$DESKTOP_ENV is not supported."
    fi
}

DESKTOP_ENV=$(echo $XDG_CURRENT_DESKTOP)
echo "Desktop is $DESKTOP_ENV"
cd "$TOOLS_FOLDER"/temp || exit
install_packages
install_flatpaks
attempt_to_install_broken_apps
