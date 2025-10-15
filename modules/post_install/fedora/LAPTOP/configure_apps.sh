#!/usr/bin/bash
flatpak_overrides(){
    flatpak override net.lutris.Lutris --user --filesystem=xdg-config/MangoHud:ro
    flatpak override dev.goats.xivlauncher --user --filesystem=xdg-config/MangoHud:ro
}

flatpak_overrides
cp -r "$TOOLS_FOLDER/modules/configs/game-profiles/LAPTOP" "$HOME"/.config/MangoHud/
cp "$TOOLS_FOLDER/modules/configs/shortcuts/XIVFPS.desktop" "$HOME"/.local/share/applications/XIVFPS.desktop