#!/usr/bin/bash

### Main launch script which sets some variables

export TOOLS_FOLDER                             # stores full path for dsks-tools
export DISTRO=""                                # stores distro name.
export VERSION_ID=""
export COPYRIGHT="Copyright (c) 2024-2025 Jordan Bottoms"
TOOLS_FOLDER=$(pwd)
mkdir "TOOLS_FOLDER"/temp
"$TOOLS_FOLDER"/modules/menu.sh
