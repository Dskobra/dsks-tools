#!/usr/bin/bash
"$TOOLS_FOLDER"/modules/post_install/fedora/shared/configure_system.sh
sudo systemctl enable --now lactd
