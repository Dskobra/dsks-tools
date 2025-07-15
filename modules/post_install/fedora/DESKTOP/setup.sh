#!/usr/bin/bash
## custom script to setup my desktop. Installs some additional packages
# and does some configurations
##########----------install packages----------##########
"$TOOLS_FOLDER"/modules/post_install/desktop/install_packages.sh
##########----------install packages----------##########

##########----------configure hardware----------##########
"$TOOLS_FOLDER"/modules/post_install/desktop/configure_hardware.sh
##########----------configure hardware----------##########

##########----------configure system----------##########
"$TOOLS_FOLDER"/modules/post_install/desktop/configure_system.sh
##########----------configure system----------##########

##########----------configure apps----------##########
"$TOOLS_FOLDER"/modules/post_install/desktop/configure_apps.sh
##########----------configure apps----------##########
