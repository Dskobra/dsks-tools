#!/usr/bin/bash

install_packages_fedora(){
    sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf install -y rpmfusion-free-release-tainted
    sudo dnf config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
    wget https://mega.nz/linux/repo/Fedora_43/x86_64/megasync-Fedora_43.x86_64.rpm && sudo dnf install -y "$PWD/megasync-Fedora_43.x86_64.rpm"
    sudo dnf install -y vim-enhanced distrobox openrgb cpu-x remmina isoimagewriter nextcloud-client steam goverlay virt-manager flatpak vlc \
    openshot tilix brave-browser clamav clamav-update clamd firewall-applet discord cockpit cockpit-files cockpit-kdump cockpit-selinux \
    cockpit-session-recording qemu-kvm virt-install libvirt-daemon-kvm libvirt-daemon-config-network docker-compose-switch wget curl \
    dnf-plugins-core gamemode.x86_64 gamemode.i686 steam-devices xfburn


    cd "$TOOLS_FOLDER/temp" || exit
    if [ "$XDG_CURRENT_DESKTOP" == "KDE" ]
    then
        curl -L -o dolphin-megasync.rpm https://mega.nz/linux/repo/Fedora_43/x86_64/dolphin-megasync-5.4.0-2.1.x86_64.rpm
    elif [ "$XDG_CURRENT_DESKTOP" == "GNOME" ]
    then
        curl -L -o nautilus-megasync.rpm https://mega.nz/linux/repo/Fedora_43/x86_64/nautilus-megasync-5.4.0-1.1.x86_64.rpm
        sudo dnf install -y gnome-shell-extension-appindicator gnome-tweaks dconf-editor file-roller \
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

install_packages_opensuse(){
    cd "$TOOLS_FOLDER/temp" || exit
    sudo zypper -n install --auto-agree-with-licenses  git git-gui distrobox OpenRGB cpu-x remmina steam \
    goverlay opi vlc clamav firewall-applet virt-manager steam-devices gamemode docker-compose-switch \
    setroubleshoot-server podman i2c-tools systemd-zram-service zram-generator nextcloud-desktop \
    v4l2loopback-kmp-default v4l2loopback-kmp-longterm v4l2loopback-autoload cockpit cockpit-selinux \
    libvirt lutris xfburn


    sudo opi -n megasync
    sudo opi -n brave

    if [ "$XDG_CURRENT_DESKTOP" == "KDE" ]
    then
        sudo zypper -n install kate kate-plugins kleopatra partitionmanager
    elif [ "$XDG_CURRENT_DESKTOP" == "GNOME" ]
    then
        sudo zypper -n install gnome-tweaks dconf-editor file-roller snapshot yaru-icon-theme \
        partitionmanager
    else
        echo "$XDG_CURRENT_DESKTOP is not supported."
    fi
    cd "$TOOLS_FOLDER/temp" || exit
    curl -L -o proton-mail.rpm $PROTON_MAIL
    curl -L -o proton-pass.rpm $PROTON_PASS
    curl -L -o proton-authenticator.rpm $PROTON_AUTH
    sudo zypper -n install --allow-unsigned-rpm *.rpm
    rm *.rpm
    
    sudo zypper addrepo -cfp 80 'https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/' packman
    sudo zypper addrepo -cfp 99 'https://opensuse-guide.org/repo/openSUSE_Tumbleweed/' libdvdcss
    sudo zypper --gpg-auto-import-keys -n ref

    sudo zypper -n install libdvdcss2
    sudo zypper -n install --from packman --allow-vendor-change ffmpeg gstreamer-plugins-good \
    gstreamer-plugins-bad gstreamer-plugins-ugly gstreamer-plugins-libav libavcodec \
    vlc vlc-qt vlc-codec-gstreamer vlc-codecs discord 


    sudo zypper -n rm lftp kmahjongg kmines kreversi ksudoku icewm icewm-config-upstream \
    yast2-firewall yast2-network yast2-country yast2-printer yast2-proxy yast2-scanner \
    yast2-services-manager xscreensaver xscreensaver-data gnome-mahjongg swell-foop \
    quadrapassel gnome-mines gnome-chess lightsoff gnome-sudoku cheese gnome-extensions \
    totem gnome-photos xterm yast2-kdump
    sudo zypper -n dup
}

install_other(){
    # install nodejs
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
    source ~/.bashrc
    nvm install lts/*

    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    # most important
    flatpak install -y flathub com.github.tchx84.Flatseal

    # tools
    flatpak install -y flathub io.missioncenter.MissionCenter it.mijorus.gearlever io.github.arunsivaramanneo.GPUViewer \
    org.gtkhash.gtkhash com.vysp3r.ProtonPlus com.github.Matoking.protontricks

    # entertainment
    flatpak install -y flathub info.cemu.Cemu org.DolphinEmu.dolphin-emu com.pokemmo.PokeMMO

    # misc
    flatpak install -y flathub org.raspberrypi.rpi-imager com.obsproject.Studio io.podman_desktop.PodmanDesktop

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
if [ "$DISTRO" == "fedora" ]
then
    install_packages_fedora
    install_other
elif [ "$DISTRO" == "opensuse-tumbleweed" ]
then
    install_packages_opensuse
    install_other
else
    echo "error"
fi
zenity --warning --text="Reminder to restart terminal so it sees nodejs to install bash lsp"
