#!/usr/bin/bash
install_packages(){
    cd "$TOOLS_FOLDER/temp" || exit
    sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

    sudo dnf install -y kate kate-plugins kdiff3 git git-gui gh git-cola vim-enhanced python3-idle toolbox distrobox \
    openrgb cpu-x remmina k3b isoimagewriter kleopatra xfburn steam-devices gamemode.x86_64 gamemode.i686 goverlay \
    virt-manager qemu-kvm virt-install libvirt-daemon-kvm libvirt-daemon-config-network docker-compose-switch \
    ShellCheck python3-lsp-server python3-devel pcre2-devel make gcc sqlite-devel openssl-devel libevent-devel \
    systemd-devel mysql-devel postgresql-devel zlib-devel zenity wget curl flatpak dnf-plugins-core dnfdragora \
    driverctl clamav clamav-update clamd firewall-applet pcre2-devel make gcc sqlite-devel openssl-devel \
    libevent-devel systemd-devel mysql-devel postgresql-devel

    sudo dnf group install -y c-development development-tools container-management


    wget https://mega.nz/linux/repo/Fedora_42/x86_64/megasync-Fedora_42.x86_64.rpm && sudo dnf install -y "$PWD/megasync-Fedora_42.x86_64.rpm"
    DESKTOP_TYPE=$(echo $XDG_CURRENT_DESKTOP)
    echo $DESKTOP_TYPE
    if [ "$DESKTOP_TYPE" == "kde " ]
    then
        curl -L -o dolphin-megasync.rpm https://mega.nz/linux/repo/Fedora_42/x86_64/dolphin-megasync-5.4.0-1.1.x86_64.rpm
    elif [ "$DESKTOP_TYPE" == "GNOME" ]
    then
        sudo dnf install -y gnome-shell-extension-appindicator gnome-tweaks
       curl -L -o nautilus-megasync.rpm https://mega.nz/linux/repo/Fedora_42/x86_64/nautilus-megasync-5.3.0-1.1.x86_64.rpm
    else
        echo "Uknown error."
    fi
    # install from local web server

    curl -L -o proton-mail.rpm https://proton.me/download/mail/linux/1.9.0/ProtonMail-desktop-beta.rpm
    curl -L -o proton-pass.rpm https://proton.me/download/pass/linux/proton-pass-1.32.3-1.x86_64.rpm
    curl -L -o proton-authenticator.rpm https://proton.me/download/authenticator/linux/ProtonAuthenticator-1.0.0-1.x86_64.rpm

    sudo dnf install -y *.rpm
    rm *.rpm
    sudo dnf remove -y firefox firefox-langpacks vlc libreoffice*
}

install_akmods(){
    sudo dnf install -y akmod-nvidia nvidia-settings xorg-x11-drv-nvidia-cuda akmod-v4l2loopback v4l2loopback
    sudo sh -c 'echo "%_with_kmod_nvidia_open 1" > /etc/rpm/macros.nvidia-kmod'
    sudo dnf install -y rpmfusion-nonfree-release-tainted
    sudo dnf install -y akmod-nvidia-open
    sudo akmods --rebuild --force
    sudo dracut --regenerate-all --force
}
install_flatpaks(){
    flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo

    # most important
    flatpak install --user -y flathub com.github.tchx84.Flatseal com.brave.Browser org.mozilla.firefox org.cockpit_project.CockpitClient \
    com.discordapp.Discord


    # tools
    flatpak install --user -y flathub  io.missioncenter.MissionCenter it.mijorus.gearlever io.github.arunsivaramanneo.GPUViewer \
    org.gtkhash.gtkhash com.vysp3r.ProtonPlus  com.github.Matoking.protontricks

    # entertainment
    flatpak install --user -y flathub net.lutris.Lutris com.valvesoftware.Steam info.cemu.Cemu org.DolphinEmu.dolphin-emu \
    dev.goats.xivlauncher com.pokemmo.PokeMMO runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08 \
    runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/24.08

    # misc
    flatpak install --user -y flathub  org.raspberrypi.rpi-imager org.videolan.VLC com.obsproject.Studio org.openshot.OpenShot \
    io.podman_desktop.PodmanDesktop org.qownnotes.QOwnNotes org.libreoffice.LibreOffice
}

install_packages
#install_akmods
install_flatpaks


# install nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
source ~/.bashrc
nvm install lts/*
zenity --warning --text="Reminder to restart terminal so it sees nodejs to install bash lsp"
