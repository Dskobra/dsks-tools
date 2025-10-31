#!/usr/bin/bash
"$TOOLS_FOLDER"/modules/post-install/distro/shared/install_packages.sh
flatpak install --user -y flathub io.github.ilya_zlobintsev.LACT
zenity --warning --text="Reminder to restart terminal so it sees nodejs to install bash lsp"
