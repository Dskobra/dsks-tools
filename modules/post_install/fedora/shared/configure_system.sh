#!/usr/bin/bash
configure_security(){
    sudo sed -i -e "/^#*LocalSocket\s/s/^#//" /etc/clamd.d/scan.conf
    sudo freshclam
    sudo systemctl enable --now clamav-freshclam.service clamd@scan.service
    sudo semanage boolean -m -1 antivirus_can_scan_system

    sudo sed -i '/SELINUX=enforcing/c SELINUX=permissive' /etc/selinux/config

    sudo firewall-cmd --set-default-zone=home
    sudo firewall-cmd --permanent --add-service=kdeconnect
    sudo firewall-cmd --permanent --add-service=cockpit
    sudo firewall-cmd --zone=home --add-port=1716-1764/tcp
    sudo firewall-cmd --zone=home --add-port=1716-1764/udp
    sudo firewall-cmd --set-log-denied=all
    sudo firewall-cmd --reload
    sudo systemctl enable --now sshd
    sudo systemctl enable --now cockpit.socket
}

configure_system_settings(){
    # set zram swap from default 8gb to 16gb
    sudo cp /usr/lib/systemd/zram-generator.conf /usr/lib/systemd/zram-generator.conf.bak
    sudo sed -i '/zram-size = min(ram, 8192)/c zram-size = min(ram, 16500)' /usr/lib/systemd/zram-generator.conf
    # Default Fedora hides the grub menu. I prefer it visible (like having the option when testing new kernels, nvidia driver breaks
    # or just cause)

    sudo grub2-editenv - unset menu_auto_hide
    sudo usermod -aG libvirt "$USER"
    sudo modprobe ntsync
    sudo touch /etc/modules-load.d/ntsync.conf
    echo "ntsync"  | sudo tee  /etc/modules-load.d/ntsync.conf > /dev/null
    sudo sed -i '/GRUB_TIMEOUT=5/c GRUB_TIMEOUT=12' /etc/default/grub
}
configure_yaru_icon_pack(){
    cd "$TOOLS_FOLDER"/modules/configs/icons || exit
    unzip yaru-icon-repack.zip
    mkdir "$HOME"/.local/share/icons/
    mv "$TOOLS_FOLDER"/modules/configs/icons/yaru-icon-repack/icons/Yaru* "$HOME"/.local/share/icons/
    rm -r "$TOOLS_FOLDER"/modules/configs/icons/yaru-icon-repack

}

personalize_desktop(){
    if [ "$XDG_CURRENT_DESKTOP" == "KDE" ]
    then
        echo ""
    elif [ "$XDG_CURRENT_DESKTOP" == "GNOME" ]
    then
        configure_yaru_icon_pack
    else
        echo "$XDG_CURRENT_DESKTOP is not supported."
    fi
}
flatpak_overrides(){
    flatpak override net.lutris.Lutris --user --filesystem=xdg-config/MangoHud:ro
    flatpak override dev.goats.xivlauncher --user --filesystem=xdg-config/MangoHud:ro
}
configure_security
configure_system_settings
flatpak_overrides
personalize_desktop
mkdir "$HOME"/.local/share/applications/
cp "$TOOLS_FOLDER/modules/configs/shortcuts/XIVFPS.desktop" "$HOME"/.local/share/applications/XIVFPS.desktop
npm i -g bash-language-server