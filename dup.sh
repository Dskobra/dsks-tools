#!/usr/bin/bash

flatpak update -y
flatpak remove --unused -y
sudo zypper ref
sudo zypper -n dup