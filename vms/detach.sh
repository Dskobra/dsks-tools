#!/usr/bin/bash
# This script dettaches or removes the network adapter and gpu device
# from the virtual machine and makes it available to the host.
PCI_NETWORK="pci_0000_07_00_0"
PCI_GPU_VIDEO="pci_0000_0a_00_0"
PCI_GPU_AUDIO="pci_0000_0a_00_1"

sudo virsh nodedev-detach $PCI_NETWORK
sudo virsh nodedev-detach $PCI_GPU_VIDEO
sudo virsh nodedev-detach $PCI_GPU_AUDIO


