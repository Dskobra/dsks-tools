#!/usr/bin/bash
build_ossec(){
    cd "$TOOLS_FOLDER/temp" || exit
    curl -L -o ossec.tar.gz https://github.com/ossec/ossec-hids/archive/3.8.0.tar.gz
    tar -xvf ossec.tar.gz
    cd ossec-hids-3.8.0 || exit
    sudo ./install.sh
}

build_ossec
