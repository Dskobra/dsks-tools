#!/usr/bin/bash
"$TOOLS_FOLDER"/modules/post_install/opensuse/shared/install_packages.sh

curl -L -o lact.rpm https://github.com/ilya-zlobintsev/LACT/releases/download/v0.8.1/lact-0.8.1-0.x86_64.opensuse-tumbleweed.rpm
sudo zypper -n --no-gpg-checks install  *.rpm
rm *.rpm

