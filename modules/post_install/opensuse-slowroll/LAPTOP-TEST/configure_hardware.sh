#!/usr/bin/bash
##########----------configure hardware----------##########
sudo sed -i '/GRUB_CMDLINE_LINUX_DEFAULT="splash=silent quiet security=selinux selinux=1 mitigations=auto rd.driver.blacklist=nouveau"/c GRUB_CMDLINE_LINUX_DEFAULT="splash=silent quiet security=selinux selinux=1 mitigations=auto crashkernel=512M rd.driver.blacklist=nouveau,nova_core modprobe.blacklist=nouveau,nova_core nvidia-drm.modeset amd_iommu=on iommu=pt acpi_enforce_resources=lax"' /etc/default/grub
sudo sed -i '/GRUB_TIMEOUT=5/c GRUB_TIMEOUT=12' /etc/default/grub
sudo grub2-mkconfig -o /etc/grub2.cfg
## setup drive mount points/permissions
mkdir -p ~/Drives/game_drive
echo "LABEL=game_drive                              /home/jordan/Drives/game_drive      btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
sudo systemctl daemon-reload
sudo mount -av

# OpenRGB needs a a couple kernel mods loaded
# for smbus access. So make sure they are
# automatically loaded on boot
sudo modprobe i2c-dev
sudo modprobe i2c-piix4
sudo touch /etc/modules-load.d/i2c.conf
sudo sh -c 'echo "i2c-dev" >> /etc/modules-load.d/i2c.conf'
sudo sh -c 'echo "i2c-piix4" >> /etc/modules-load.d/i2c.conf'
sudo i2cdetect -l
##########----------configure hardware----------##########
