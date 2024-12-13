#!/usr/bin/bash

## setup corectrl by running the corectrl.py script
cd "configs" || exit
python3 corectrl.py
sudo cp "90-corectrl.rules" "/etc/polkit-1/rules.d/90-corectrl.rules"
sudo chown root:root "/etc/polkit-1/rules.d/90-corectrl.rules"
