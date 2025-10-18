#!/usr/bin/bash
configure_drives(){
    ## setup drive mount points/permissions
    mkdir /var/home/jordan/Drives/
    mkdir /var/home/jordan/Drives/data
    mkdir /var/home/jordan/Drives/games
    mkdir /var/home/jordan/Drives/vms
    mkdir var/home/jordan/Drives/shared
    echo "LABEL=data                                  /var/home/jordan/Drives/data             btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
    echo "LABEL=games                                 /var/home/jordan/Drives/games            btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
    echo "LABEL=vms                                   /var/home/jordan/Drives/vms              btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
    echo "LABEL=shared                                /var//home/jordan/Drives/shared          ntfs    nofail,users,exec             0 0 " | sudo tee -a /etc/fstab > /dev/null
    sudo systemctl daemon-reload
    sudo mount -av
}

configure_games(){
    if test -f "/var/home/jordan/Drives/games/.DRIVESTATE.txt"; then
        echo "Games drive is already set up."
    elif ! test -f "/var/home/jordan/Drives/games/.DRIVESTATE.txt"; then
        echo "Setting up games drive folders."
        mkdir /var/home/jordan/Drives/games/Cemu
        mkdir /var/home/jordan/Drives/games/Lutris
        game_profiles
        echo "0" > /var/home/jordan/Drives/games/.DRIVESTATE.txt
    fi
    # Dont use home permissions in flatseal otherwise during the setup for Cemu
    # drives will be listed twice in the drop-down list. Also shows them twice in the
    # file chooser on the left. So just give specific permissions.
    flatpak override info.cemu.Cemu --user --filesystem=/var/home/jordan/Drives/games/Cemu/
}

flatpak_overrides(){
    flatpak override com.valvesoftware.Steam  --user --filesystem=/var/home/jordan/Drives/games/
    flatpak override info.cemu.Cemu --user --filesystem=/var/home/jordan/Drives/games/Cemu/
}

configure_drives
configure_games
flatpak_overrides
cp -r "$TOOLS_FOLDER/modules/configs/game-profiles/DESKTOP" "$HOME"/.config/MangoHud/
#ln -s "$HOME"/.local/share/gnome-boxes"  "$HOME"/Drives/vms/boxes
sudo rpm-ostree kargs --append="amd_iommu=on iommu=pt amdgpu.ppfeaturemask=0xffffffff crashkernel=512M"
