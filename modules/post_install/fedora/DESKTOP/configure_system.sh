#!/usr/bin/bash
sudo systemctl enable --now lactd
"$TOOLS_FOLDER"/modules/post_install/fedora/shared/configure_system.sh
