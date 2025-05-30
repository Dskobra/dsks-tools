#!/usr/bin/bash
# This script reattaches the network adapter and gpu device
# from the host to the virtual machine

PCI_NETWORK="pci_0000_07_00_0"
PCI_GPU_VIDEO="pci_0000_0a_00_0"
PCI_GPU_AUDIO="pci_0000_0a_00_1"

sudo virsh nodedev-reattach $PCI_NETWORK
sudo virsh nodedev-reattach $PCI_GPU_VIDEO
sudo virsh nodedev-reattach $PCI_GPU_AUDIO
