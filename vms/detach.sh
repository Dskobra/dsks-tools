#!/usr/bin/bash
PCI_NETWORK="pci_0000_07_00_0"
PCI_GPU_VIDEO="pci_0000_0a_00_0"
PCI_GPU_AUDIO="pci_0000_0a_00_1"

sudo virsh nodedev-detach $PCI_NETWORK
sudo virsh nodedev-detach $PCI_GPU_VIDEO
sudo virsh nodedev-detach $PCI_GPU_AUDIO


