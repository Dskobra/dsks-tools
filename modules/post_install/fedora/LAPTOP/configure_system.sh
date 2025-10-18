#!/usr/bin/bash
"$TOOLS_FOLDER"/modules/post_install/fedora/shared/configure_system.sh
sudo sed -i '/GRUB_CMDLINE_LINUX="rhgb quiet rd.driver.blacklist=nouveau,nova_core modprobe.blacklist=nouveau,nova_core"/c GRUB_CMDLINE_LINUX="amd_iommu=on iommu=pt rd.driver.blacklist=nouveau,nova_core modprobe.blacklist=nouveau,nova_core nvidia-drm.modeset acpi_enforce_resources=lax crashkernel=512M rhgb quiet"' /etc/default/grub
sudo grub2-mkconfig -o /etc/grub2.cfg
cp -r "$TOOLS_FOLDER/modules/configs/game-profiles/LAPTOP" "$HOME"/.config/MangoHud/
