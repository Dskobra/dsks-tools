#!/usr/bin/bash
games_drive(){
    if test -f "/home/jordan/Drives/game_drive/.DRIVESTATE.txt"; then
        echo "Games drive is already set up."
    elif ! test -f "/home/jordan/Drives/game_drive/.DRIVESTATE.txt"; then
        echo "Setting up games drive folders."
        mkdir /home/jordan/Drives/game_drive/MangoHud
        mkdir /home/jordan/Drives/game_drive/Cemu
        mkdir /home/jordan/Drives/game_drive/Lutris
        mkdir /home/jordan/Drives/game_drive/Xlcore
        mkdir /home/jordan/Drives/game_drive/Xlcore/ffxiv/
        mkdir /home/jordan/Drives/game_drive/Xlcore/ffxivConfig/
        mkdir /home/jordan/Drives/game_drive/Xlcore/patch/
        game_profiles
        echo "0" > /home/jordan/Drives/game_drive/.DRIVESTATE.txt
    fi
    ln -s /home/jordan/Drives/game_drive/MangoHud /home/jordan/.config/MangoHud
    # for xiv launcher to run with mangohud you need to launch it with
    # /usr/bin/mangohud flatpak run dev.goats.xivlauncher, mangohud 24.08
    # from flathub and permissions to mangohud configs. Home/host
    # permissions dont work.
    cp "$TOOLS_FOLDER"/modules/configs/xivlauncher ~/Desktop
    flatpak install --user -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/24.08
    flatpak override dev.goats.xivlauncher --user --filesystem=xdg-config/MangoHud:ro
    # Dont use home permissions in flatseal otherwise during the setup for Cemu
    # drives will be listed twice in the drop-down list. Also shows them twice in the
    # file chooser on the left. So just give specific permissions.
    flatpak override info.cemu.Cemu --user --filesystem=/home/jordan/Drives/game_drive/Cemu/
}

game_profiles(){
     #setup mangohud profiles
     cd "$TOOLS_FOLDER/temp" || exit
     git clone https://github.com/dskobra/game-profiles
     cd "$TOOLS_FOLDER/temp/game-profiles" || exit
     python "$TOOLS_FOLDER/modules/post_install/config_pci.py" "0:01:00.0"
     chown "$USER":"$USER" *.conf
     cp *.conf /home/jordan/Drives/game_drive/MangoHud/
     git stash       # reset profiles after copying
}

setup_ffxiv(){
    cd "$TOOLS_FOLDER/temp" || exit
    curl -L -o configs.tar.gz http://192.168.50.101/downloads/configs.tar.gz
    tar -xvf configs.tar.gz
    mkdir ~/.xlcore
    cp "$TOOLS_FOLDER/temp/configs/ffxiv/launcher.ini" ~/.xlcore/launcher.ini
}
##########----------configure apps----------##########
##########----------apps----------##########
games_drive
setup_ffxiv
##########----------apps----------##########
