#!/usr/bin/bash
install_packages(){
    sudo rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo rpm-ostree apply-live

    sudo rpm-ostree install kate kate-plugins python3-idle vim-enhanced git-gui gh git-cola kdiff3 python3-lsp-server  virt-manager ShellCheck \
    sqlite-devel openssl-devel libevent-devel systemd-devel mysql-devel postgresql-devel zlib-devel pcre2-devel python3-devel openrgb k3b xfburn steam-devices \
    goverlay dnfdragora driverctl clamav clamav-update clamd firewall-applet zenity

    # install megasync
    wget https://mega.nz/linux/repo/Fedora_42/x86_64/megasync-Fedora_42.x86_64.rpm

    # install from local web server
    curl -L -o dolphin-megasync.rpm https://mega.nz/linux/repo/Fedora_42/x86_64/dolphin-megasync-5.4.0-1.1.x86_64.rpm
    curl -L -o ocs-url.rpm http://192.168.50.101/downloads/ocs-url-3.1.0-1.fc20.x86_64.rpm
    curl -L -o proton-mail.rpm https://proton.me/download/mail/linux/1.9.0/ProtonMail-desktop-beta.rpm
    curl -L -o proton-pass.rpm https://proton.me/download/pass/linux/proton-pass-1.32.3-1.x86_64.rpm
    curl -L -o proton-authenticator.rpm https://proton.me/download/authenticator/linux/ProtonAuthenticator-1.0.0-1.x86_64.rpm

    sudo rpm-ostree install -y *.rpm
    rm *.rpm
    sudo rpm-ostree apply-live
}

attempt_to_install_broken_apps(){
    # dev tools are sometimes broken due to mismatches
    sudo rpm-ostree install akmod-v4l2loopback v4l2loopback gamemode.i686 make gcc
}

install_flatpaks(){
    flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo

    # most important
    flatpak install --user -y flathub com.github.tchx84.Flatseal com.brave.Browser org.mozilla.firefox org.openshot.OpenShot org.remmina.Remmina org.cockpit_project.CockpitClient \
    com.discordapp.Discord
    # tools
    flatpak install --user -y  io.missioncenter.MissionCenter it.mijorus.gearlever io.github.arunsivaramanneo.GPUViewer org.gtkhash.gtkhash  \
    io.github.thetumultuousunicornofdarkness.cpu-x io.github.ilya_zlobintsev.LACT com.vysp3r.ProtonPlus com.github.Matoking.protontricks
    #kde
    flatpak install --user -y flathub org.kde.okular org.kde.gwenview org.kde.kleopatra org.kde.kolourpaint org.kde.kpat

    #entertainment
    flatpak install --user -y flathub  net.lutris.Lutris com.valvesoftware.Steam info.cemu.Cemu org.DolphinEmu.dolphin-emu dev.goats.xivlauncher \
    com.pokemmo.PokeMMO runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08

    # misc
    flatpak install --user -y flathub org.raspberrypi.rpi-imager  org.videolan.VLC com.obsproject.Studio io.podman_desktop.PodmanDesktop org.qownnotes.QOwnNotes \
    org.libreoffice.LibreOffice
}

install_extra_apps(){
    # install nodejs
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
    source ~/.bashrc
    nvm install lts/*
    # distrobox
    curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh

    curl -L -o shellcheck-v0.11.0.linux.x86_64.tar.xz https://github.com/koalaman/shellcheck/releases/download/v0.11.0/shellcheck-v0.11.0.linux.x86_64.tar.xz
    tar -xvf shellcheck-v0.11.0.linux.x86_64.tar.xz
    cd shellcheck-v0.11.0.linux.x86_64 || exit
    sudo mv shellcheck /usr/local/bin

}

cd "$TOOLS_FOLDER"/temp || exit
install_packages
attempt_to_install_broken_apps
install_extra_apps
zenity --warning --text="Reminder reboot first before doing next step."


