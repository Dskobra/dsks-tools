#!/usr/bin/bash
configure_zram(){
    # set zram swap from default 8gb to 16gb
    cd "$TOOLS_FOLDER"/temp || exit
    touch zram-generator.conf
    echo "[zram0]" >> zram-generator.conf
    echo "zram-size = min(ram, 16500)" >> zram-generator.conf
    sudo mv zram-generator.conf /etc/systemd/zram-generator.conf
}

configure_security(){
    sudo sed -i '/SELINUX=enforcing/c SELINUX=permissive' /etc/selinux/config

    sudo firewall-cmd --set-default-zone=home
    sudo firewall-cmd --permanent --add-service=kdeconnect
    sudo firewall-cmd --set-log-denied=all 
    sudo firewall-cmd --reload
}

configure_system_settings(){
    # Default Fedora hides the grub menu. I prefer it visible (like having the option when testing new kernels, nvidia driver breaks
    # or just cause)

    sudo grub2-editenv - unset menu_auto_hide
    echo "set timeout=12" | sudo tee /boot/grub2/user.cfg > /dev/null
    # https://docs.fedoraproject.org/en-US/fedora-silverblue/troubleshooting/#_unable_to_add_user_to_group
    grep -E '^libvirt:' /usr/lib/group | sudo tee -a /etc/group
    sudo usermod -aG libvirt "$USER"
    sudo modprobe ntsync
    sudo touch /etc/modules-load.d/ntsync.conf
    echo "ntsync"  | sudo tee  /etc/modules-load.d/ntsync.conf > /dev/null
    sudo systemctl enable --now sshd
    sudo systemctl enable --now libvirtd
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

hide_firefox_from_desktop(){
    # hides firefox from gnome/kde
    sudo mkdir -p /usr/local/share/applications/
    sudo cp /usr/share/applications/org.mozilla.firefox.desktop /usr/local/share/applications/
    sudo sed -i "2a\\NotShowIn=GNOME;KDE" /usr/local/share/applications/org.mozilla.firefox.desktop
    sudo update-desktop-database /usr/local/share/applications/
}

flatpak_overrides(){

}

configure_zram
configure_security
configure_system_settings
personalize_desktop
hide_firefox_from_desktop
flatpak_overrides

npm i -g bash-language-server
flatpak override net.lutris.Lutris --user --filesystem=xdg-config/MangoHud:ro