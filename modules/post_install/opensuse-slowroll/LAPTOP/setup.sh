#!/usr/bin/bash
##########----------install packages----------##########
"$TOOLS_FOLDER"/modules/post_install/opensuse-slowroll/LAPTOP/install_packages.sh
##########----------install packages----------##########

##########----------configure hardware----------##########
"$TOOLS_FOLDER"/modules/post_install/opensuse-slowroll/LAPTOP/configure_hardware.sh
##########----------configure hardware----------##########

##########----------configure system----------##########
"$TOOLS_FOLDER"/modules/post_install/opensuse-slowroll/LAPTOP/configure_system.sh
##########----------configure system----------##########

##########----------configure apps----------##########
"$TOOLS_FOLDER"/modules/post_install/opensuse-slowroll/LAPTOP/configure_apps.sh
##########----------configure apps----------##########
