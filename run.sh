#!/usr/bin/bash

### Main launch script which sets some variables

export TOOLS_FOLDER
export DISTRO_FOLDER                                                   
export DISTRO_NAME=""                                
export DISTRO_VER=""
export OSTREE_VER=""
export DISTRO=""
export COPYRIGHT="Copyright (c) 2024-2025 Jordan Bottoms"

DISTRO_NAME=$(source /etc/os-release ; echo $ID)                      # store basic distro name
DISTRO_VER=$(source /etc/os-release ; echo "$VERSION_ID")             # store distro version number
OSTREE_VER=$(source /etc/os-release ; echo "$OSTREE_VERSION")

TOOLS_FOLDER=$(pwd)                                                   # stores full path for dsks-tools
DISTRO_FOLDER="$TOOLS_FOLDER"/modules/post-install/distro
mkdir "$TOOLS_FOLDER"/temp                                            # check if supported distro
"$TOOLS_FOLDER"/modules/core/menu.sh