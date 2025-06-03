#!/usr/bin/bash

##########----------hardware----------##########
sudo sed -i '/GRUB_CMDLINE_LINUX="rhgb quiet"/c GRUB_CMDLINE_LINUX="amd_iommu=on iommu=pt rd.driver.blacklist=nouveau modprobe.blacklist=nouveau nvidia-drm.modeset acpi_enforce_resources=lax crashkernel=512M rhgb quiet"' /etc/default/grub
sudo sed -i '/GRUB_TIMEOUT=5/c /GRUB_TIMEOUT=12' /etc/default/grub
##########----------hardware----------##########
