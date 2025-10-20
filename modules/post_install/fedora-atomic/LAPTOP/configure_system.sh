#!/usr/bin/bash
"$TOOLS_FOLDER"/modules/post_install/fedora-atomic/shared/configure_system.sh
cp -r "$TOOLS_FOLDER/modules/configs/game-profiles/LAPTOP" "$HOME"/.config/MangoHud/

# seems flatpak only sees nvidia drivers once installed on system. So run an update during the lastp step of these
# setup scripts
flatpak update -y   