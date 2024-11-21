#!/usr/bin/bash

# copies my personal mangohud profiles into ~/.config/MangoHud

if test -f /home/"$USER"/.config/MangoHud/MangoHud.conf; then
    echo "MangoHud.conf exists. Not copying profiles over."
elif ! test -f /home/"$USER"/.config/MangoHud/MangoHud.conf; then
    git clone https://github.com/Dskobra/game-profiles
    cd game-profiles || exit
    chown "$USER":"$USER" *.conf
    cp *.conf "$HOME"/.config/MangoHud/
fi
