#!/usr/bin/bash

##########----------configure apps----------##########
cd "$TOOLS_FOLDER/temp" || exit
git clone https://github.com/dskobra/game-profiles
cd "$TOOLS_FOLDER/temp/game-profiles" || exit
mkdir "$HOME"/.config/MangoHud/
python "$TOOLS_FOLDER/modules/post_install/config_pci.py" "0:01:00.0"
chown "$USER":"$USER" *.conf
cp *.conf "$HOME"/.config/MangoHud/
git stash       # reset profiles after copying

# for xiv launcher to run with mangohud you need to launch it with
# /usr/bin/mangohud flatpak run dev.goats.xivlauncher, mangohud 24.08
# from flathub and permissions to mangohud configs. Home/host
# permissions dont work.
cp "$TOOLS_FOLDER"/modules/configs/xivlauncher ~/Desktop
flatpak install --user -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/24.08
flatpak override dev.goats.xivlauncher --user --filesystem=xdg-config/MangoHud:ro
##########----------configure apps----------##########
