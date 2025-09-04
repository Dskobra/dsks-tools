#!/usr/bin/bash
sudo dnf copr enable -y ilyaz/LACT
sudo dnf install -y lact
"$TOOLS_FOLDER"/modules/post_install/fedora/shared/install_packages.sh
