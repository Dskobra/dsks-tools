#!/usr/bin/bash

corectrl(){
    ## setup corectrl by running the corectrl.py script
    cd "$TOOLS_FOLDER"/modules/configs || exit
    python3 corectrl.py
    sudo cp "90-corectrl.rules" "/etc/polkit-1/rules.d/90-corectrl.rules"
    sudo chown root:root "/etc/polkit-1/rules.d/90-corectrl.rules"

}

corectrl
