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
        "$TOOLS_FOLDER"/modules/menu.sh
    else
        echo "These scripts only support Fedora 42/43."
    fi

}

export TOOLS_FOLDER                                                   # stores full path for dsks-tools
export DISTRO_NAME=""                                
export DISTRO_VER=""
export DESKTOP_ENV=""
export COPYRIGHT="Copyright (c) 2024-2025 Jordan Bottoms"

DISTRO_NAME=$(source /etc/os-release ; echo $ID)                      # store basic distro name
DISTRO_VER=$(source /etc/os-release ; echo "$VERSION_ID")             # store distro version number
DESKTOP_ENV=$(echo $XDG_CURRENT_DESKTOP)                              # store desktop name (gnome, kde etc)

TOOLS_FOLDER=$(pwd)
mkdir "$TOOLS_FOLDER"/temp
distro_check                                                          # check if supported distro