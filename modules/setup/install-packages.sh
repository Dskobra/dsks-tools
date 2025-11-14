#!/usr/bin/bash
################################
### section for fedora /w dnf
################################
install_fedora_packages(){
    sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf install -y rpmfusion-free-release-tainted
    sudo dnf install -y vim-enhanced toolbox distrobox openrgb cpu-x remmina isoimagewriter steam steam-devices gamemode.x86_64 \
    gamemode.i686 goverlay virt-manager qemu-kvm virt-install libvirt-daemon-kvm libvirt-daemon-config-network docker-compose-switch \
    wget curl flatpak dnf-plugins-core clamav clamav-update clamd firewall-applet discord cockpit cockpit-files cockpit-kdump \
    cockpit-selinux cockpit-session-recording vlc openshot tilix

    # codecs some stuff is taken from the below guide
    # https://github.com/devangshekhawat/Fedora-43-Post-Install-Guide
    sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1
    sudo dnf -y swap ffmpeg-free ffmpeg --allowerasing

    sudo dnf swap -y mesa-va-drivers mesa-va-drivers-freeworld
    sudo dnf swap -y mesa-va-drivers.i686 mesa-va-drivers-freeworld.i686

    sudo dnf swap -y mesa-vulkan-drivers mesa-vulkan-drivers-freeworld
    sudo dnf swap -y mesa-vulkan-drivers.i686 mesa-vulkan-drivers-freeworld.i686

    sudo dnf group install -y multimedia
    sudo dnf install -y openh264 gstreamer1-plugin-openh264 mozilla-openh264 libdvdcss
    sudo dnf upgrade -y @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin

    if [ "$XDG_CURRENT_DESKTOP" == "KDE" ]
    then
        sudo dnf install -y k3b
    elif [ "$XDG_CURRENT_DESKTOP" == "GNOME" ]
    then
        sudo dnf install -y gnome-shell-extension-appindicator gnome-tweaks dconf-editor file-roller xfburn \
        i2c-tools kde-partitionmanager
    else
        echo "$XDG_CURRENT_DESKTOP is not supported."
    fi

}

install_fedora_third_party_packages(){
    cd "$TOOLS_FOLDER/temp" || exit
    sudo dnf config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
    sudo dnf install -y brave-browser
    wget https://mega.nz/linux/repo/Fedora_43/x86_64/megasync-Fedora_43.x86_64.rpm && sudo dnf install -y "$PWD/megasync-Fedora_43.x86_64.rpm"
    wget "https://repo.protonvpn.com/fedora-$(cat /etc/fedora-release | cut -d' ' -f 3)-stable/protonvpn-stable-release/protonvpn-stable-release-1.0.3-1.noarch.rpm"
    sudo dnf install -y ./protonvpn-stable-release-1.0.3-1.noarch.rpm && sudo dnf check-update -y --refresh
    sudo dnf install -y  proton-vpn-gnome-desktop
    rm protonvpn-stable-release-1.0.3-1.noarch.rpm

    if [ "$XDG_CURRENT_DESKTOP" == "KDE" ]
    then
        curl -L -o dolphin-megasync.rpm https://mega.nz/linux/repo/Fedora_43/x86_64/dolphin-megasync-5.4.0-2.1.x86_64.rpm
    elif [ "$XDG_CURRENT_DESKTOP" == "GNOME" ]
    then
        curl -L -o nautilus-megasync.rpm https://mega.nz/linux/repo/Fedora_43/x86_64/nautilus-megasync-5.4.0-1.1.x86_64.rpm
    else
        echo "$XDG_CURRENT_DESKTOP is not supported."
    fi
}

################################
### end section
################################

################################
### section for openSUSE
################################
install_opensuse_packages(){
    cd "$TOOLS_FOLDER/temp" || exit
    sudo zypper -n install --auto-agree-with-licenses setroubleshoot-server git git-gui gh git-cola python313-idle \
    patterns-containers-container_runtime distrobox OpenRGB cpu-x remmina steam steam-devices gamemode goverlay \
    virt-manager docker-compose-switch ShellCheck clamav firewall-applet i2c-tools python313-python-lsp-server \
    systemd-zram-service zram-generator v4l2loopback-kmp-default v4l2loopback-kmp-longterm v4l2loopback-autoload \
    python313-devel opi vlc kdump

    sudo opi -n megasync
    sudo opi -n brave

    if [ "$XDG_CURRENT_DESKTOP" == "KDE" ]
    then
        sudo zypper -n install k3b kate kate-plugins kdiff3 kleopatra
    elif [ "$XDG_CURRENT_DESKTOP" == "GNOME" ]
    then
        sudo zypper -n install gnome-tweaks dconf-editor file-roller xfburn snapshot yaru-icon-theme \
        kde-partitionmanager
    else
        echo "$XDG_CURRENT_DESKTOP is not supported."
    fi
}

cleanup_opensuse_packages(){
    sudo zypper -n rm lftp kmahjongg kmines kreversi ksudoku icewm icewm-config-upstream \
    yast2-firewall yast2-network yast2-country yast2-printer yast2-proxy yast2-scanner \
    yast2-services-manager xscreensaver xscreensaver-data gnome-mahjongg swell-foop \
    quadrapassel gnome-mines gnome-chess lightsoff gnome-sudoku cheese gnome-extensions \
    totem gnome-photos xterm yast2-kdump
}

################################
### end section
################################


install_packages(){
    # install nodejs
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
    source ~/.bashrc
    nvm install lts/*

    flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo

    # most important
    flatpak install --user -y flathub com.github.tchx84.Flatseal

    # tools
    flatpak install --user -y flathub  io.missioncenter.MissionCenter it.mijorus.gearlever io.github.arunsivaramanneo.GPUViewer \
    org.gtkhash.gtkhash com.vysp3r.ProtonPlus com.github.Matoking.protontricks

    # entertainment
    flatpak install --user -y flathub net.lutris.Lutris info.cemu.Cemu org.DolphinEmu.dolphin-emu \
    dev.goats.xivlauncher com.pokemmo.PokeMMO runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08 \
    runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/24.08

    # misc
    flatpak install --user -y flathub org.raspberrypi.rpi-imager com.obsproject.Studio io.podman_desktop.PodmanDesktop \
    org.qownnotes.QOwnNotes

    cd "$TOOLS_FOLDER/temp" || exit
    curl -L -o proton-mail.rpm https://proton.me/download/mail/linux/1.10.1/ProtonMail-desktop-beta.rpm
    curl -L -o proton-pass.rpm https://proton.me/download/pass/linux/proton-pass-1.32.11-1.x86_64.rpm
    curl -L -o proton-authenticator.rpm https://proton.me/download/authenticator/linux/ProtonAuthenticator-1.1.4-1.x86_64.rpm

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

echo "Desktop is $XDG_CURRENT_DESKTOP"
if [ "$1" == "fedora" ]
then
    install_fedora_packages
    install_fedora_third_party_packages
    cd "$TOOLS_FOLDER/temp" || exit
    sudo dnf install -y *.rpm
    rm *.rpm
    sudo dnf remove -y libreoffice*
elif [ "$1" == "opensuse" ]
then
    install_opensuse_packages
    cleanup_opensuse_packages
    cd "$TOOLS_FOLDER/temp" || exit
    sudo zypper -n --no-gpg-checks install  *.rpm
    rm *.rpm
else
    echo "error"
fi

install_packages
zenity --warning --text="Reminder to restart terminal so it sees nodejs to install bash lsp"