#!/usr/bin/bash

##########----------hardware----------##########
sudo sed -i '/GRUB_CMDLINE_LINUX="rhgb quiet"/c GRUB_CMDLINE_LINUX="amd_iommu=on iommu=pt amdgpu.ppfeaturemask=0xffffffff acpi_enforce_resources=lax crashkernel=512M rhgb quiet"' /etc/default/grub
sudo sed -i '/GRUB_TIMEOUT=5/c GRUB_TIMEOUT=12' /etc/default/grub
sudo grub2-mkconfig -o /etc/grub2.cfg
## setup drive mount points/permissions
mkdir ~/Drives/shared_drive
mkdir ~/Drives/game_drive
mkdir -p ~/Drives/vm_drive
echo "/dev/nvme0n1p1                              /home/jordan/Drives/shared_drive     btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
echo "/dev/nvme2n1p1                              /home/jordan/Drives/game_drive       btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
echo "/dev/sda1                                   /home/jordan/Drives/vm_drive         btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
sudo systemctl daemon-reload
sudo mount -av

# setup wifi adapters for virtualization by
# adding few drivers to initramfs, set permissions
# on config, rebuild initramfs than bind wifi adapters
# to vfio driver with driverctl
PCI_WIFI_ADAPTER_ONE="0000:07:00.0"
PCI_WIFI_ADAPTER_TWO="0000:08:00.0"
echo 'add_driver+=" vfio vfio_iommu_type1 vfio_pci vfio_virqfd "' | sudo tee /etc/dracut.conf.d/local.conf > /dev/null
sudo chown root:root "/etc/dracut.conf.d/local.conf"
sudo dracut --regenerate-all --force    # rebuild initramfs for all installed kernels
sudo driverctl set-override $PCI_WIFI_ADAPTER_ONE vfio-pci
sudo driverctl set-override $PCI_WIFI_ADAPTER_TWO vfio-pci

# OpenRGB needs a a couple kernel mods loaded
# for smbus access. So make sure they are
# automatically loaded on boot
sudo modprobe i2c-dev
sudo modprobe i2c-piix4
sudo touch /etc/modules-load.d/i2c.conf
sudo sh -c 'echo "i2c-dev" >> /etc/modules-load.d/i2c.conf'
sudo sh -c 'echo "i2c-piix4" >> /etc/modules-load.d/i2c.conf'
sudo i2cdetect -l
##########----------hardware----------##########
