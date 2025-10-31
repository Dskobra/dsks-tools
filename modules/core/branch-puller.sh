#!/usr/bin/bash

# checks what distro then pulls it from a sub branch
distro_check(){
    # check if fedora
    if [ "$DISTRO_NAME" == "fedora" ]
    then
        fedora_release_check
    else
        echo "Unupported distro."
    fi

}

fedora_release_check(){
    if [ "$DISTRO_VER" == "42" ] || [ "$DISTRO_VER" == "43" ]
    then
        ostree_check
        #"$TOOLS_FOLDER"/modules/menu.sh
    else
        echo "These scripts only support Fedora 42/43."
    fi

}

ostree_check(){
    cd "$TOOLS_FOLDER"/modules/post-install/ || exit
    if [ -z  "$OSTREE_VER" ]
    then
        echo "Not running Fedora atomic"
        rm -r -f distro
        git clone https://github.com/dskobra/dsks-tools -b fedora
        mv dsks-tools distro
    else
        echo "Running atomic version $OSTREE_VER"
        rm -r -f distro
        git clone https://github.com/dskobra/dsks-tools -b fedora-atomic
        mv dsks-tools distro
    fi
    "$TOOLS_FOLDER"/modules/post-install/distro/post-menu.sh

}

game_profiles(){
    cd "$TOOLS_FOLDER"/modules/ || exit
    rm -r -f game-profiles
    git clone https://github.com/dskobra/dsks-tools -b mangohud
    mv dsks-tools game-profiles

}


if [ "$1" == "distro" ]
then
    distro_check
elif [ "$1" == "game-profiles" ]
then
    game_profiles
else
    echo "error"
fi