#!/usr/bin/bash

##########----------hardware----------##########
sudo sed -i '/GRUB_CMDLINE_LINUX="rhgb quiet"/c GRUB_CMDLINE_LINUX="amd_iommu=on iommu=pt amdgpu.ppfeaturemask=0xffffffff acpi_enforce_resources=lax crashkernel=512M rhgb quiet"' /etc/default/grub
sudo sed -i '/GRUB_TIMEOUT=5/c /GRUB_TIMEOUT=12' /etc/default/grub
## setup labels
mkdir -p ~/Drives/vms
mkdir ~/Drives/external
mkdir ~/Drives/shared
mkdir ~/Drives/games
echo "LABEL=vms                                   /home/jordan/Drives/vms        btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
echo "LABEL=external                              /home/jordan/Drives/external   btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
echo "LABEL=shared                                /home/jordan/Drives/shared     btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
echo "LABEL=games                                 /home/jordan/Drives/games      btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
sudo systemctl daemon-reload
mount -av

PCI_WIFI_ONE="0000:07:00.0"
PCI_WIFI_TWO="0000:08:00.0"

# copy over custom dracut config
echo 'add_driver+=" vfio vfio_iommu_type1 vfio_pci vfio_virqfd "' | sudo tee /etc/dracut.conf.d/local.conf > /dev/null

# set permissions to root
sudo chown root:root "/etc/dracut.conf.d/local.conf"

# rebuild initramfs
sudo dracut --regenerate-all --force    # rebuild initramfs for all installed kernels

# Use driverctl to rebind the pci devices to the vfio-pci driver
# this allows vfio-pci driver to control it for virtualization
sudo driverctl set-override $PCI_WIFI_ONE vfio-pci
sudo driverctl set-override $PCI_WIFI_TWO vfio-pci
##########----------hardware----------##########
