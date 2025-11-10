#!/usr/bin/bash
flatpak_overrides(){
    flatpak override net.lutris.Lutris --user --filesystem=xdg-config/MangoHud:ro
    flatpak override info.cemu.Cemu --user --filesystem=/home/jordan/Drives/game_drive/Cemu/
}


flatpak_overrides
npm i -g bash-language-server
cp "$TOOLS_FOLDER/modules/configs/XIVFPS.desktop" /home/jordan/.local/share/applications/XIVFPS.desktop
cp -r "$TOOLS_FOLDER/modules/configs/game-profiles/LAPTOP" "$HOME"/.config/MangoHud/
