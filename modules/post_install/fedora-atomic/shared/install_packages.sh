#!/usr/bin/bash
install_packages(){
    sudo rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo rpm-ostree apply-live

    sudo rpm-ostree install virt-manager openrgb firewall-applet zenity i2c-tools

    wget "https://repo.protonvpn.com/fedora-$(cat /etc/fedora-release | cut -d' ' -f 3)-stable/protonvpn-stable-release/protonvpn-stable-release-1.0.3-1.noarch.rpm"
    sudo rpm-ostree install ./protonvpn-stable-release-1.0.3-1.noarch.rpm && sudo rpm-ostree apply-live
    sudo rpm-ostree refresh-md && sudo rpm-ostree install proton-vpn-gnome-desktop

    # dev tools are sometimes broken due to mismatches on mirrors. Might have to wait several hours.
    sudo rpm-ostree install gamemode.i686

    # distrobox
    curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh
}
install_flatpaks(){
    flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo

    # most important
    flatpak install --user -y flathub com.github.tchx84.Flatseal com.brave.Browser org.mozilla.firefox org.cockpit_project.CockpitClient

    # tools
    flatpak install --user -y flathub  io.missioncenter.MissionCenter it.mijorus.gearlever io.github.arunsivaramanneo.GPUViewer \
    org.gtkhash.gtkhash com.vysp3r.ProtonPlus com.github.Matoking.protontricks org.kde.isoimagewriter

    # entertainment
    flatpak install --user -y flathub net.lutris.Lutris info.cemu.Cemu org.DolphinEmu.dolphin-emu \
    dev.goats.xivlauncher com.pokemmo.PokeMMO runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08 \
    runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/24.08

    # misc
    flatpak install --user -y flathub org.raspberrypi.rpi-imager com.obsproject.Studio io.podman_desktop.PodmanDesktop \
    org.qownnotes.QOwnNotes

    if [ "$DESKTOP_ENV" == "KDE" ]
    then
        echo ""
    elif [ "$DESKTOP_ENV" == "GNOME" ]
    then
       flatpak install --user -y flathub com.mattjakeman.ExtensionManager org.gnome.baobab org.gnome.font-viewer \
       org.gnome.Loupe org.gnome.Papers org.gnome.Boxes page.tesk.Refine
    else
        echo "$DESKTOP_ENV is not supported."
    fi
}

DESKTOP_ENV=$(echo $XDG_CURRENT_DESKTOP)
echo "Desktop is $DESKTOP_ENV"
cd "$TOOLS_FOLDER"/temp || exit
install_packages
install_flatpaks
