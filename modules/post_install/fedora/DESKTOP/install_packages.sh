#!/usr/bin/bash
"$TOOLS_FOLDER"/modules/post_install/fedora/shared/install_packages.sh
sudo dnf copr enable -y ilyaz/LACT
sudo dnf install -y lact

sudo dnf swap -y mesa-va-drivers mesa-va-drivers-freeworld
sudo dnf swap -y mesa-va-drivers.i686 mesa-va-drivers-freeworld.i686

sudo dnf swap -y mesa-vulkan-drivers mesa-vulkan-drivers-freeworld
sudo dnf swap -y mesa-vulkan-drivers.i686 mesa-vulkan-drivers-freeworld.i686



