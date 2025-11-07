#!/usr/bin/bash

# checks what distro then pulls it from a sub branch

CHECK_DISTRO_FOLDER(){
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
    cd "$TOOLS_FOLDER"/modules/post-install/ || exit
    if [ "$DISTRO_NAME" == "fedora" ]
    then
        fedora_release_check
    elif [ "$DISTRO_NAME" == "opensuse-tumbleweed" ]
    then
        git clone https://github.com/dskobra/dsks-tools -b opensuse
        mv dsks-tools distro
        EDITION="opensuse"
        echo $EDITION > "$TOOLS_FOLDER"/.edition.txt   
    else
        echo "Unupported distro."
        "$TOOLS_FOLDER"/modules/core/menu.sh
    fi
}

fedora_release_check(){
    if [ "$DISTRO_VER" == "42" ] || [ "$DISTRO_VER" == "43" ]
    then
        ostree_check
    else
        echo "These scripts only support Fedora 42/43."
        "$TOOLS_FOLDER"/modules/core/menu.sh
    fi

}

ostree_check(){
    cd "$TOOLS_FOLDER"/modules/post-install/ || exit
    if [ -z  "$OSTREE_VER" ]
    then
        echo "Not running Fedora atomic"
        git clone https://github.com/dskobra/dsks-tools -b fedora
        mv dsks-tools distro
        EDITION="fedora"
        echo $EDITION > "$TOOLS_FOLDER"/.edition.txt
    else
        echo "Running atomic version $OSTREE_VER"
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
    cd "$DISTRO_FOLDER" || exit
    "$TOOLS_FOLDER"/modules/post-install/distro/post-menu.sh "$EDITION"
elif [ "$1" == "game-profiles" ]
then
    game_profiles
else
    echo "error"
fi
