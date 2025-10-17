#!/usr/bin/bash
install_packages(){
    sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h\n" | sudo tee -a /etc/yum.repos.d/vscodium.repo
    sudo dnf update -y
    sudo dnf group install -y rpm-development-tools development-tools c-development
    sudo dnf install -y kate kdiff3 kommit python3-idle vim-X11 gh git-cola vim-enhanced python3-lsp-server python3-devel \
    ShellCheck codium meld zenity
}

configure_shortcuts(){
    # IDEs
    cp "$TOOLS_FOLDER"/modules/configs/shortcuts/vscodium.desktop "$HOME"/.local/share/applications/
    cp /usr/share/pixmaps/vscodium.png "$HOME"/.local/share/icons/

    cp "$TOOLS_FOLDER"/modules/configs/shortcuts/org.kde.kate.desktop "$HOME"/.local/share/applications/
    cp /usr/share/icons/hicolor/scalable/apps/kate.svg "$HOME"/.local/share/icons/

    cp "$TOOLS_FOLDER"/modules/configs/shortcuts/idle3.desktop "$HOME"/.local/share/applications/
    cp /usr/share/icons/hicolor/48x48/apps/idle3.png "$HOME"/.local/share/icons/

    cp "$TOOLS_FOLDER"/modules/configs/shortcuts/gvim.desktop "$HOME"/.local/share/applications/
    cp /usr/share/icons/hicolor/48x48/apps/gvim.png "$HOME"/.local/share/icons/

    cp "$TOOLS_FOLDER"/modules/configs/shortcuts/org.gnome.Meld.desktop "$HOME"/.local/share/applications/
    cp /usr/share/icons/hicolor/scalable/apps/org.gnome.Meld.svg "$HOME"/.local/share/icons/

    cp "$TOOLS_FOLDER"/modules/configs/shortcuts/git-cola.desktop "$HOME"/.local/share/applications/
    cp /usr/share/icons/hicolor/scalable/apps/git-cola.svg "$HOME"/.local/share/icons/

    


}
if [ -z "$container" ]
then
    echo "Not in a container. Closing."
elif [ -n "$container" ]
then
    install_packages
    #configure_shortcuts
    # switched to toolbox as distrobox seems to have problems installing
    # libicu on atomic distros. This leaves several apps broken.

    # libicu seems fixed now. Maybe weird cache/server issue? Anyway keep an
    # eye on it.
    distrobox-export --app kate
    distrobox-export --app codium
    distrobox-export --app idle
    distrobox-export --app kdiff3
    distrobox-export --app git-cola
else 
    echo ""
fi