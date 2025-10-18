#!/usr/bin/bash
"$TOOLS_FOLDER"/modules/post_install/fedora/shared/configure_system.sh
configure_drives(){
    ## setup drive mount points/permissions
    mkdir /home/jordan/Drives/
    mkdir /home/jordan/Drives/data
    mkdir /home/jordan/Drives/games
    mkdir /home/jordan/Drives/vms
    mkdir /home/jordan/Drives/shared
    echo "LABEL=data                                  /home/jordan/Drives/data             btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
    echo "LABEL=games                                 /home/jordan/Drives/games            btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
    echo "LABEL=vms                                   /home/jordan/Drives/vms              btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
    echo "LABEL=shared                                /home/jordan/Drives/shared           ntfs    nofail,users,exec             0 0 " | sudo tee -a /etc/fstab > /dev/null
    sudo systemctl daemon-reload
    sudo mount -av
}
configure_drives
sudo systemctl enable --now lactd
sudo sed -i '/GRUB_CMDLINE_LINUX="rhgb quiet"/c GRUB_CMDLINE_LINUX="amd_iommu=on iommu=pt amdgpu.ppfeaturemask=0xffffffff crashkernel=512M rhgb quiet"' /etc/default/grub
sudo grub2-mkconfig -o /etc/grub2.cfg

npm i -g bash-language-server
cp "$TOOLS_FOLDER/modules/configs/shortcuts/XIVFPS.desktop" /home/"$USER"/.local/share/applications/XIVFPS.desktop
cp -r "$TOOLS_FOLDER/modules/configs/game-profiles/DESKTOP" "$HOME"/.config/MangoHud/
ln -s  "$HOME"/.local/share/gnome-boxes/images "$HOME"/Drives/vms/boxes