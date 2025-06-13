#!/usr/bin/bash
games_drive(){
    if test -f "/home/jordan/Drives/games/.DRIVESTATE.txt"; then
        echo "Games drive is already set up."
    elif ! test -f "/home/jordan/Drives/games/.DRIVESTATE.txt"; then
        echo "Setting up games drive folders."
        mkdir /home/jordan/Drives/games/MangoHud
        mkdir /home/jordan/Drives/games/Cemu
        mkdir /home/jordan/Drives/games/Lutris
        mkdir /home/jordan/Drives/games/Xlcore
        mkdir /home/jordan/Drives/games/Xlcore/ffxiv/
        mkdir /home/jordan/Drives/games/Xlcore/ffxivConfig/
        mkdir /home/jordan/Drives/games/Xlcore/patch/
        game_profiles
        echo "0" > /home/jordan/Drives/games/.DRIVESTATE.txt
    fi
    ln -s /home/jordan/Drives/games/MangoHud /home/jordan/.config/MangoHud
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
    flatpak override info.cemu.Cemu --user --filesystem=/home/jordan/Drives/games/Cemu/
}

game_profiles(){
     #setup mangohud profiles
     cd "$TOOLS_FOLDER/temp" || exit
     git clone https://github.com/dskobra/game-profiles
     cd "$TOOLS_FOLDER/temp/game-profiles" || exit
     python "$TOOLS_FOLDER/modules/post_install/config_pci.py" "0:03:00.0"
     chown "$USER":"$USER" *.conf
     cp *.conf /home/jordan/Drives/games/MangoHud/
     git stash       # reset profiles after copying
}
##########----------apps----------##########
games_drive


##########----------apps----------##########
#/home/jordan/Drives/games/xlcore/
