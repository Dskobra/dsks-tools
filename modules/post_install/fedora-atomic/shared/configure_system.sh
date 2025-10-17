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
    #sudo sed -i -e "/^#*LocalSocket\s/s/^#//" /etc/clamd.d/scan.conf
    #sudo freshclam
    #sudo systemctl enable --now clamav-freshclam.service clamd@scan.service
    #sudo semanage boolean -m -1 antivirus_can_scan_system

    sudo sed -i '/SELINUX=enforcing/c SELINUX=permissive' /etc/selinux/config

    sudo firewall-cmd --set-default-zone=home
    sudo firewall-cmd --permanent --add-service=kdeconnect
    sudo firewall-cmd --set-log-denied=all 
    sudo firewall-cmd --reload
    sudo systemctl enable --now sshd
}

configure_system_settings(){
    # Default Fedora hides the grub menu. I prefer it visible (like having the option when testing new kernels, nvidia driver breaks
    # or just cause)

    sudo grub2-editenv - unset menu_auto_hide
    # https://docs.fedoraproject.org/en-US/fedora-silverblue/troubleshooting/#_unable_to_add_user_to_group
    grep -E '^libvirt:' /usr/lib/group | sudo tee -a /etc/group
    sudo usermod -aG libvirt $USER
    sudo modprobe ntsync
    sudo touch /etc/modules-load.d/ntsync.conf
    echo "ntsync"  | sudo tee  /etc/modules-load.d/ntsync.conf > /dev/null
}

configure_yaru_icon_pack(){
    cd "$TOOLS_FOLDER"/modules/configs/icons || exit
    unzip yaru-icon-repack.zip
    mkdir /home/"$USER"/.local/share/icons/
    mv "$TOOLS_FOLDER"/modules/configs/icons/yaru-icon-repack/icons/Yaru* /home/"$USER"/.local/share/icons/
    rm -r "$TOOLS_FOLDER"/modules/configs/icons/yaru-icon-repack

}

personalize_desktop(){
    if [ "$DESKTOP_ENV" == "KDE" ]
    then
        echo ""
    elif [ "$DESKTOP_ENV" == "GNOME" ]
    then
        configure_yaru_icon_pack
    else
        echo "$DESKTOP_ENV is not supported."
    fi
}

configure_zram
configure_security
configure_system_settings
personalize_desktop
