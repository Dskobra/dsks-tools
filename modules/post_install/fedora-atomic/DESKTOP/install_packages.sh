#!/usr/bin/bash
"$TOOLS_FOLDER"/modules/post_install/fedora/shared/install_packages.sh
flatpak install --user -y flathub io.github.ilya_zlobintsev.LACT

