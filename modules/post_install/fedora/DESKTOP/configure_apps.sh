#!/usr/bin/bash
configure_games(){
    if test -f "/home/jordan/Drives/games/.DRIVESTATE.txt"; then
        echo "Games drive is already set up."
    elif ! test -f "/home/jordan/Drives/games/.DRIVESTATE.txt"; then
        echo "Setting up games drive folders."
        mkdir /home/jordan/Drives/games/Cemu
        echo "0" > /home/jordan/Drives/games/.DRIVESTATE.txt
    fi
    # Dont use home permissions in flatseal otherwise during the setup for Cemu
    # drives will be listed twice in the drop-down list. Also shows them twice in the
    # file chooser on the left. So just give specific permissions.
    flatpak override info.cemu.Cemu --user --filesystem=/home/jordan/Drives/games/Cemu/
}

flatpak_overrides(){
    flatpak override net.lutris.Lutris --user --filesystem=xdg-config/MangoHud:ro
    flatpak override dev.goats.xivlauncher --user --filesystem=xdg-config/MangoHud:ro
    flatpak override info.cemu.Cemu --user --filesystem=/home/jordan/Drives/games/Cemu/
}
configure_games
flatpak_overrides
npm i -g bash-language-server
cp "$TOOLS_FOLDER/modules/configs/XIVFPS.desktop" /home/jordan/.local/share/applications/XIVFPS.desktop
cp -r "$TOOLS_FOLDER/modules/configs/game-profiles/DESKTOP" "$HOME"/.config/MangoHud/
ln -s "/home/jordan/.local/share/gnome-boxes/images" "/home/jordan/Drives/vms/boxes"

