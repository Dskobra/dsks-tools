#!/usr/bin/bash

### shared packages between my devices.
install_fedora_rpmfusion_packages(){
    
    sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf install -y vim-enhanced toolbox distrobox openrgb i2c-tools cpu-x remmina isoimagewriter steam steam-devices gamemode.x86_64 \
    gamemode.i686 goverlay virt-manager qemu-kvm virt-install libvirt-daemon-kvm libvirt-daemon-config-network docker-compose-switch \
    zenity wget curl flatpak dnf-plugins-core clamav clamav-update clamd firewall-applet discord cockpit cockpit-files cockpit-kdump \
    cockpit-selinux cockpit-session-recording

    sudo dnf group install -y c-development development-tools container-management
    sudo dnf -y swap ffmpeg-free ffmpeg --allowerasing
}

install_other_apps(){
    cd "$TOOLS_FOLDER/temp" || exit
    wget https://mega.nz/linux/repo/Fedora_42/x86_64/megasync-Fedora_42.x86_64.rpm && sudo dnf install -y "$PWD/megasync-Fedora_42.x86_64.rpm"
    wget "https://repo.protonvpn.com/fedora-$(cat /etc/fedora-release | cut -d' ' -f 3)-stable/protonvpn-stable-release/protonvpn-stable-release-1.0.3-1.noarch.rpm"
    sudo dnf install -y ./protonvpn-stable-release-1.0.3-1.noarch.rpm && sudo dnf check-update -y --refresh
    sudo dnf install -y  proton-vpn-gnome-desktop
    rm protonvpn-stable-release-1.0.3-1.noarch.rpm

    if [ "$XDG_CURRENT_DESKTOP" == "KDE" ]
    then
        sudo dnf install -y k3b
        curl -L -o dolphin-megasync.rpm https://mega.nz/linux/repo/Fedora_42/x86_64/dolphin-megasync-5.4.0-2.1.x86_64.rpm
    elif [ "$XDG_CURRENT_DESKTOP" == "GNOME" ]
    then
        sudo dnf install -y gnome-shell-extension-appindicator gnome-tweaks dconf-editor file-roller xfburn
        curl -L -o nautilus-megasync.rpm https://mega.nz/linux/repo/Fedora_42/x86_64/nautilus-megasync-5.4.0-1.1.x86_64.rpm
    else
        echo "$XDG_CURRENT_DESKTOP is not supported."
    fi

    curl -L -o proton-mail.rpm https://proton.me/download/mail/linux/1.9.0/ProtonMail-desktop-beta.rpm
    curl -L -o proton-pass.rpm https://proton.me/download/pass/linux/proton-pass-1.32.3-1.x86_64.rpm
    curl -L -o proton-authenticator.rpm https://proton.me/download/authenticator/linux/ProtonAuthenticator-1.0.0-1.x86_64.rpm

    sudo dnf install -y *.rpm
    rm *.rpm
}
install_flatpaks(){
    flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo

    # most important
    flatpak install --user -y flathub com.github.tchx84.Flatseal com.brave.Browser org.mozilla.firefox

    # tools
    flatpak install --user -y flathub  io.missioncenter.MissionCenter it.mijorus.gearlever io.github.arunsivaramanneo.GPUViewer \
    org.gtkhash.gtkhash com.vysp3r.ProtonPlus com.github.Matoking.protontricks

    # entertainment
    flatpak install --user -y flathub net.lutris.Lutris info.cemu.Cemu org.DolphinEmu.dolphin-emu \
    dev.goats.xivlauncher com.pokemmo.PokeMMO runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08 \
    runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/24.08

    # misc
    flatpak install --user -y flathub org.raspberrypi.rpi-imager org.videolan.VLC com.obsproject.Studio org.openshot.OpenShot \
    io.podman_desktop.PodmanDesktop org.qownnotes.QOwnNotes

    if [ "$XDG_CURRENT_DESKTOP" == "KDE" ]
    then
        echo ""
    elif [ "$XDG_CURRENT_DESKTOP" == "GNOME" ]
    then
       flatpak install --user -y flathub com.mattjakeman.ExtensionManager
    else
        echo "$XDG_CURRENT_DESKTOP is not supported."
    fi
}

cleanup(){
    sudo dnf remove -y firefox firefox-langpacks vlc libreoffice*
}

echo "Desktop is $XDG_CURRENT_DESKTOP"
install_fedora_rpmfusion_packages
install_other_app
install_flatpaks
cleanup
