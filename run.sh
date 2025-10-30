#!/usr/bin/bash

### Main launch script which sets some variables
distro_check(){
    # check if fedora
    if [ "$DISTRO_NAME" == "fedora" ]
    then
        fedora_release_check
    else
        echo "Unfortunately, '$DISTRO_NAME $DISTRO_VER' is not a supported distro."
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
    cd "$TOOLS_FOLDER"/modules/post_install/ || exit
    if [ -z  "$OSTREE_VER" ]
    then
        echo "Not running Fedora atomic"
        git clone https://github.com/dskobra/dsks-tools -b fedora
        mv dsks-tools distro
        "$TOOLS_FOLDER"/modules/post-install/fedora/os-menu.sh
    else
        echo "Running atomic version $OSTREE_VER"
        git clone https://github.com/dskobra/dsks-tools -b fedora-atomic
        mv dsks-tools distro
        "$TOOLS_FOLDER"/modules/post-install/distro/post-menu.sh
    fi

}
export TOOLS_FOLDER                                                   
export DISTRO_NAME=""                                
export DISTRO_VER=""
export OSTREE_VER=""
export COPYRIGHT="Copyright (c) 2024-2025 Jordan Bottoms"

DISTRO_NAME=$(source /etc/os-release ; echo $ID)                      # store basic distro name
DISTRO_VER=$(source /etc/os-release ; echo "$VERSION_ID")             # store distro version number
OSTREE_VER=$(source /etc/os-release ; echo "$OSTREE_VERSION")

TOOLS_FOLDER=$(pwd)                                                   # stores full path for dsks-tools
mkdir "$TOOLS_FOLDER"/temp
distro_check                                                          # check if supported distro