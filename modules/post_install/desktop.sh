#!/usr/bin/bash
### install packages
sudo dnf install -y dnfdragora cockpit cockpit-composer cockpit-bridge \
cockpit-doc cockpit-image-builder cockpit-kdump  cockpit-files \
cockpit-networkmanager cockpit-ws-selinux cockpit-ws cockpit-system \
cockpit-storaged cockpit-sosreport cockpit-session-recording cockpit-selinux \
cockpit-podman cockpit-packagekit cockpit-machines Shellcheck python3-lsp-server

# install locally stored packages
cd ~/Drives/shared/packages || exit
sudo rpm -i dolphin-megasync-*.x86_64.rpm
sudo rpm -i ocs-url-*.x86_64.rpm
sudo rpm -i ProtonMail-desktop-beta.rpm
sudo rpm -i ProtonPass.rpm
npm i -g bash-language-server

### end installing packages

### configure system
"$TOOLS_FOLDER"/modules/fixes/grub.sh "amd_grub"
sudo sed -i '/SELINUX=enforcing/c SELINUX=permissive' /etc/selinux/config
sudo firewall-cmd --permanent --set-default-zone=home
sudo firewall-cmd --permanent --add-service=cockpit
sudo firewall-cmd --permanent --add-service=kdeconnect
sudo firewall-cmd --set-log-denied=all
sudo fireall-cmd --reload
sudo systemctl enable --now sshd
sudo systemctl enable --now cockpit.socket


## setup labels
mkdir -p ~/Drives/vms
mkdir ~/Drives/external
mkdir ~/Drives/shared
mkdir ~/Drives/games
#echo "LABEL=vms                                   /home/jordan/Drives/vms        btrfs   nofail,users,exec             0 0" >> /etc/fstab
#echo "LABEL=external                              /home/jordan/Drives/external   btrfs   nofail,users,exec             0 0" >> /etc/fstab
#echo "LABEL=shared                                /home/jordan/Drives/shared     btrfs   nofail,users,exec             0 0 " >> /etc/fstab
#echo "LABEL=games                                 /home/jordan/Drives/games      btrfs   nofail,users,exec             0 0 " >> /etc/fstab
#mount -av
### end of configuring system



