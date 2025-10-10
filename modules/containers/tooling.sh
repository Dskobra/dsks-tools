#!/usr/bin/bash
install_packages(){
    sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h\n" | sudo tee -a /etc/yum.repos.d/vscodium.repo
    sudo dnf update -y
    sudo dnf group install -y rpm-development-tools development-tools c-development
    sudo dnf install -y kate kdiff3 kommit python3-idle vim-X11 gh git-cola vim-enhanced python3-lsp-server python3-devel \
    ShellCheck codium meld zenity

    # install nodejs
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
    source ~/.bashrc
    nvm install lts/*
}

if [ -z "$container" ]
then
    echo "Not in a container. Closing."
elif [ -n "$container" ]
then
    install_packages
    distrobox-export --app kate
    distrobox-export --app codium
    distrobox-export --app idle
    distrobox-export --app kdiff3
    distrobox-export --app git-cola
    zenity --warning --text="Reminder to restart terminal so it sees nodejs to install bash lsp"
else 
    echo ""
fi