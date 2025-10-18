#!/usr/bin/bash
npm i -g bash-language-server
cp "$TOOLS_FOLDER/modules/configs/shortcuts/XIVFPS.desktop" /home/"$USER"/.local/share/applications/XIVFPS.desktop
cp -r "$TOOLS_FOLDER/modules/configs/game-profiles/DESKTOP" "$HOME"/.config/MangoHud/
ln -s  "$HOME"/.local/share/gnome-boxes/images "$HOME"/Drives/vms/boxes

