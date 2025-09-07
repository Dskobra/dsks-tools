#!/usr/bin/bash
configure_game_drive(){
    if test -f "/home/jordan/Drives/game_drive/.DRIVESTATE.txt"; then
        echo "Games drive is already set up."
    elif ! test -f "/home/jordan/Drives/game_drive/.DRIVESTATE.txt"; then
        echo "Setting up games drive folders."
        mkdir /home/jordan/Drives/game_drive/Cemu
        mkdir /home/jordan/Drives/game_drive/Lutris
        mkdir /home/jordan/Drives/game_drive/Xlcore
        mkdir /home/jordan/Drives/game_drive/Xlcore/ffxiv/
        mkdir /home/jordan/Drives/game_drive/Xlcore/ffxivConfig/
        mkdir /home/jordan/Drives/game_drive/Xlcore/patch/
        echo "0" > /home/jordan/Drives/game_drive/.DRIVESTATE.txt
    fi
    # Dont use home permissions in flatseal otherwise during the setup for Cemu
    # drives will be listed twice in the drop-down list. Also shows them twice in the
    # file chooser on the left. So just give specific permissions.
    flatpak override info.cemu.Cemu --user --filesystem=/home/jordan/Drives/game_drive/Cemu/
}

configure_ffxiv_config(){
    cd "$TOOLS_FOLDER/temp" || exit
    curl -L -o configs.tar.gz http://192.168.50.101/downloads/configs.tar.gz
    tar -xvf configs.tar.gz
    mkdir ~/.xlcore
    cp "$TOOLS_FOLDER/temp/configs/ffxiv/launcher.ini" ~/.xlcore/launcher.ini
}

flatpak_overrides(){
    flatpak override net.lutris.Lutris --user --filesystem=xdg-config/MangoHud:ro
    flatpak override com.valvesoftware.Steam  --user --filesystem=xdg-config/MangoHud:ro
    flatpak override com.valvesoftware.Steam  --user --filesystem=/home/jordan/Drives/game_drive/
    flatpak override info.cemu.Cemu --user --filesystem=/home/jordan/Drives/game_drive/Cemu/
}

configure_game_drive
flatpak_overrides
npm i -g bash-language-server
cp "$TOOLS_FOLDER/modules/configs/XIVLauncher-fps.desktop" /home/jordan/.local/share/applications/XIVLauncher-fps.desktop
cp -r "$TOOLS_FOLDER/modules/configs/game-profiles/DESKTOP" "$HOME"/.config/MangoHud/
