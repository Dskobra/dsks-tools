#!/usr/bin/bash
"$TOOLS_FOLDER"/modules/post_install/fedora/shared/configure_system.sh
sudo systemctl enable --now lactd
sudo sed -i '/GRUB_CMDLINE_LINUX="rhgb quiet"/c GRUB_CMDLINE_LINUX="amd_iommu=on iommu=pt amdgpu.ppfeaturemask=0xffffffff crashkernel=512M rhgb quiet"' /etc/default/grub
sudo grub2-mkconfig -o /etc/grub2.cfg
