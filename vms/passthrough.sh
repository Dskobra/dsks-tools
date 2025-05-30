#!/usr/bin/bash

PCI_WIFI_ONE="0000:07:00.0"
PCI_WIFI_TWO="0000:08:00.0"

sudo dnf install -y driverctl

# copy over custom dracut config
cd "$TOOLS_FOLDER/modules/configs" || exit
sudo cp "dracut_local.conf" "/etc/dracut.conf.d/local.conf"

# set permissions to root
sudo chown root:root "/etc/dracut.conf.d/local.conf"

# rebuild initramfs
#KVERSION=$(uname -r)                   # get current kernel version
#sudo dracut -f --kver $KVERSION        # rebuild initramfs for current kernel

sudo dracut --regenerate-all --force    # rebuild initramfs for all installed kernels

# Use driverctl to rebind the pci devices to the vfio-pci driver
# this allows vfio-pci driver to control it for virtualization
sudo driverctl set-override $PCI_WIFI_ONE vfio-pci
sudo driverctl set-override $PCI_WIFI_TWO vfio-pci

