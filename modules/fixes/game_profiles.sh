#!/usr/bin/bash

game_profiles(){
        git clone https://github.com/Dskobra/game-profiles
        cd game-profiles || exit
        ./install.sh
}

game_profiles
