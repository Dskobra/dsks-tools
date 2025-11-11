#!/usr/bin/bash
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
if [ "$1" == "fedora-dnf" ]
then
    "$TOOLS_FOLDER"/modules/post-install/fedora/install-packages.sh "fedora-dnf"
elif [ "$1" == "fedora-ostree" ]
then
    "$TOOLS_FOLDER"/modules/post-install/fedora/install-packages.sh "fedora-ostree"
elif [ "$1" == "opensuse" ]
then
    "$TOOLS_FOLDER"/modules/post-install/opensuse/install-packages.sh
else
    echo "error"
fi

install_packages
zenity --warning --text="Reminder to restart terminal so it sees nodejs to install bash lsp"