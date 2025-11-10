#!/usr/bin/bash
"$TOOLS_FOLDER"/modules/post-install/fedora/shared/configure-atomic-system.sh
cp -r "$TOOLS_FOLDER/modules/game-profiles/LAPTOP" "$HOME"/.config/MangoHud/

# seems flatpak only sees nvidia drivers once installed on system. So run an update during the last step of these
# setup scripts
flatpak update -y   
