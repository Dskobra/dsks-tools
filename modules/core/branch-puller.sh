#!/usr/bin/bash

# checks what distro then pulls it from a sub branch

CHECK_DISTRO_FOLDER(){
    cd "$TOOLS_FOLDER"/modules/ || exit
    DISTRO_FOLDER="$TOOLS_FOLDER"/modules/post-install/distro
    if [ -d "$DISTRO_FOLDER" ]; then
        cd "$DISTRO_FOLDER" || exit
        git stash
        git pull
        EDITION=$(cat "$TOOLS_FOLDER"/.edition.txt)
    else
        distro_check
    fi
}

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
        EDITION="fedora"
        echo $EDITION > "$TOOLS_FOLDER"/.edition.txt
    else
        echo "Running atomic version $OSTREE_VER"
        rm -r -f distro
        git clone https://github.com/dskobra/dsks-tools -b fedora
        mv dsks-tools distro
        EDITION="atomic"
        echo $EDITION > "$TOOLS_FOLDER"/.edition.txt
    fi

}

game_profiles(){
    cd "$TOOLS_FOLDER"/modules/ || exit
    PROFILES_FOLDER="$TOOLS_FOLDER"/modules/game-profiles/
    if [ -d "$PROFILES_FOLDER" ]; then
        cd "$PROFILES_FOLDER" || exit
        git stash
        git pull
    else
        git clone https://github.com/dskobra/dsks-tools -b mangohud
        mv dsks-tools game-profiles
    fi
}

EDITION=""
if [ "$1" == "distro" ]
then
    CHECK_DISTRO_FOLDER
    "$TOOLS_FOLDER"/modules/post-install/distro/post-menu.sh "$EDITION"
elif [ "$1" == "game-profiles" ]
then
    game_profiles
else
    echo "error"
fi
