#!/usr/bin/bash
install_fedora_packages(){
    sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf install -y rpmfusion-free-release-tainted
    sudo dnf config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
    wget https://mega.nz/linux/repo/Fedora_43/x86_64/megasync-Fedora_43.x86_64.rpm && sudo dnf install -y "$PWD/megasync-Fedora_43.x86_64.rpm"
    sudo dnf install -y vim-enhanced distrobox openrgb cpu-x remmina isoimagewriter nextcloud-client steam goverlay virt-manager flatpak vlc \
    openshot tilix brave-browser clamav clamav-update clamd firewall-applet discord cockpit cockpit-files cockpit-kdump cockpit-selinux \
    cockpit-session-recording qemu-kvm virt-install libvirt-daemon-kvm libvirt-daemon-config-network docker-compose-switch wget curl \
    dnf-plugins-core gamemode.x86_64 gamemode.i686 steam-devices


    cd "$TOOLS_FOLDER/temp" || exit
    if [ "$XDG_CURRENT_DESKTOP" == "KDE" ]
    then
        curl -L -o dolphin-megasync.rpm https://mega.nz/linux/repo/Fedora_43/x86_64/dolphin-megasync-5.4.0-2.1.x86_64.rpm
        sudo dnf install -y k3b
    elif [ "$XDG_CURRENT_DESKTOP" == "GNOME" ]
    then
        curl -L -o nautilus-megasync.rpm https://mega.nz/linux/repo/Fedora_43/x86_64/nautilus-megasync-5.4.0-1.1.x86_64.rpm
        sudo dnf install -y gnome-shell-extension-appindicator gnome-tweaks dconf-editor file-roller xfburn \
        i2c-tools kde-partitionmanager
    else
        echo "$XDG_CURRENT_DESKTOP is not supported."
    fi

    curl -L -o proton-mail.rpm $PROTON_MAIL
    curl -L -o proton-pass.rpm $PROTON_PASS
    curl -L -o proton-authenticator.rpm $PROTON_AUTH
    sudo dnf install -y *.rpm
    rm *.rpm

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
    sudo dnf remove -y libreoffice*

}

install_opensuse_packages(){
    cd "$TOOLS_FOLDER/temp" || exit
    sudo zypper -n install --auto-agree-with-licenses  git git-gui distrobox OpenRGB cpu-x remmina steam \
    goverlay opi vlc clamav firewall-applet virt-manager steam-devices gamemode docker-compose-switch \
    setroubleshoot-server podman i2c-tools kdump systemd-zram-service zram-generator nextcloud-desktop \
    v4l2loopback-kmp-default v4l2loopback-kmp-longterm v4l2loopback-autoload cockpit cockpit-kdump \
    cockpit-selinux libvirt


    sudo opi -n megasync
    sudo opi -n brave

    if [ "$XDG_CURRENT_DESKTOP" == "KDE" ]
    then
        sudo zypper -n install k3b kate kate-plugins kleopatra
    elif [ "$XDG_CURRENT_DESKTOP" == "GNOME" ]
    then
        sudo zypper -n install gnome-tweaks dconf-editor file-roller xfburn snapshot yaru-icon-theme \
        kde-partitionmanager
    else
        echo "$XDG_CURRENT_DESKTOP is not supported."
    fi
    cd "$TOOLS_FOLDER/temp" || exit
    curl -L -o proton-mail.rpm $PROTON_MAIL
    curl -L -o proton-pass.rpm $PROTON_PASS
    curl -L -o proton-authenticator.rpm $PROTON_AUTH
    sudo zypper -n install --allow-unsigned-rpm *.rpm
    rm *.rpm
    
    sudo zypper -n dup
    sudo opi -n codecs

    sudo zypper -n rm lftp kmahjongg kmines kreversi ksudoku icewm icewm-config-upstream \
    yast2-firewall yast2-network yast2-country yast2-printer yast2-proxy yast2-scanner \
    yast2-services-manager xscreensaver xscreensaver-data gnome-mahjongg swell-foop \
    quadrapassel gnome-mines gnome-chess lightsoff gnome-sudoku cheese gnome-extensions \
    totem gnome-photos xterm yast2-kdump
}

build_cockpit_files()
    cd "$TOOLS_FOLDER"/temp || exit
    git clone https://github.com/cockpit-project/cockpit-files.git
    cd "cockpit-files" || exit
    make
    sudo make install
    cd "$TOOLS_FOLDER"/temp || exit
    rm -r cockpit-files
install_other(){
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
    install_other
elif [ "$1" == "opensuse" ]
then
    install_opensuse_packages
    build_cockpit_files
    install_other
else
    echo "error"
fi
zenity --warning --text="Reminder to restart terminal so it sees nodejs to install bash lsp"