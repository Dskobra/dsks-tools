#!/usr/bin/bash
configure_games_drive(){
    if test -f "/var/home/jordan/Drives/game_drive/.DRIVESTATE.txt"; then
        echo "Games drive is already set up."
    elif ! test -f "/var/home/jordan/Drives/game_drive/.DRIVESTATE.txt"; then
        echo "Setting up games drive folders."
        mkdir /var/home/jordan/Drives/game_drive/Cemu
        mkdir /var/home/jordan/Drives/game_drive/Lutris
        mkdir /var/home/jordan/Drives/game_drive/Xlcore
        mkdir /var/home/jordan/Drives/game_drive/Xlcore/ffxiv/
        mkdir /var/home/jordan/Drives/game_drive/Xlcore/ffxivConfig/
        mkdir /var/home/jordan/Drives/game_drive/Xlcore/patch/
        game_profiles
        echo "0" > /var/home/jordan/Drives/game_drive/.DRIVESTATE.txt
    fi
    # Dont use home permissions in flatseal otherwise during the setup for Cemu
    # drives will be listed twice in the drop-down list. Also shows them twice in the
    # file chooser on the left. So just give specific permissions.
    flatpak override info.cemu.Cemu --user --filesystem=/var/home/jordan/Drives/game_drive/Cemu/
}

configure_game_profiles(){
     #setup mangohud profiles
     cd "$TOOLS_FOLDER/temp" || exit
     git clone https://github.com/dskobra/game-profiles
     cd "$TOOLS_FOLDER/temp/game-profiles" || exit
     python "$TOOLS_FOLDER/modules/post_install/config_pci.py" "0:01:00.0"
     chown "$USER":"$USER" *.conf
     mkdir /home/jordan/.config/MangoHud/
     cp *.conf /home/jordan/.config/MangoHud/
     git stash       # reset profiles after copying
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
    flatpak override com.valvesoftware.Steam  --user --filesystem=/var/home/jordan/Drives/game_drive/
    flatpak override info.cemu.Cemu --user --filesystem=/var/home/jordan/Drives/game_drive/Cemu/
}

configure_games_drive
configure_game_profiles
configure_ffxiv_config
flatpak_overrides
