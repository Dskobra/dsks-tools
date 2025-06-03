#!/usr/bin/bash

# dont really use gpu passthrough anymore. Personal note
# tedious and unstable mess. Possibly due to amd reset bug.
PCI_GPU_VIDEO="pci_0000_0a_00_0"
PCI_GPU_AUDIO="pci_0000_0a_00_1"

sudo dnf install -y driverctl

# copy over custom dracut config
cd "$TOOLS_FOLDER/modules/configs" || exit
sudo cp "dracut_local.conf" "/etc/dracut.conf.d/local.conf"

# set permissions to root
sudo chown root:root "/etc/dracut.conf.d/local.conf"

# rebuild initramfs
sudo dracut -f --kver `uname -r`

# Use driverctl to rebind the pci devices to the vfio-pci driver
# this allows vfio-pci driver to control it for virtualization
sudo driverctl set-override $PCI_GPU_VIDEO vfio-pci
sudo driverctl set-override $PCI_GPU_AUDIO vfio-pci

