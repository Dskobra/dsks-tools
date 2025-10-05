#!/usr/bin/bash
configure_game_drive(){
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

configure_ffxiv_config(){
    cd "$TOOLS_FOLDER/temp" || exit
    curl -L -o configs.tar.gz http://192.168.50.101/downloads/configs.tar.gz
    tar -xvf configs.tar.gz
    mkdir ~/.xlcore
    cp "$TOOLS_FOLDER/temp/configs/ffxiv/launcher.ini" ~/.xlcore/launcher.ini
}

hide_firefox_from_base_image(){
    sudo mkdir -p /usr/local/share/applications/
    sudo cp /usr/share/applications/org.mozilla.firefox.desktop /usr/local/share/applications/
    sudo sed -i "2a\\NotShowIn=GNOME;KDE" /usr/local/share/applications/org.mozilla.firefox.desktop
    sudo update-desktop-database /usr/local/share/applications/
}

flatpak_overrides(){
    flatpak override net.lutris.Lutris --user --filesystem=xdg-config/MangoHud:ro
    flatpak override com.valvesoftware.Steam  --user --filesystem=xdg-config/MangoHud:ro
    flatpak override com.valvesoftware.Steam  --user --filesystem=/var/home/jordan/Drives/game_drive/
    flatpak override info.cemu.Cemu --user --filesystem=/var/home/jordan/Drives/game_drive/Cemu/
}

configure_game_drive
configure_ffxiv_config
hide_firefox_from_base_image
flatpak_overrides


npm i -g bash-language-server
cp -r "$TOOLS_FOLDER/modules/configs/game-profiles/DESKTOP" "$HOME"/.config/MangoHud/

