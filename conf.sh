grub(){
    # backup the default fedora provided grub and kde google provider configurations
    sudo mv "/etc/default/grub" "/etc/default/grub.default.bak"

    # copy my custom grub and selinux changes into their folders
    cd "configs" || exit
    sudo cp "grub" "/etc/default/grub"


    # set the configuration files permissions to root
    sudo chown root:root "/etc/default/grub"

    # rebuild grub with the new changes
    sudo grub2-mkconfig -o /etc/grub2.cfg
}


kde_gdrive_fix(){
    # backup the default fedora provided grub and kde google provider configurations
    sudo mv "/usr/share/accounts/providers/kde/google.provider" "/usr/share/accounts/providers/kde/google.provider.bak"

    # copy my custom grub and selinux changes into their folders
    cd "configs" || exit

    ## issue with kde atm where google blocks connecting plasma to your account.
    # switching to the gnome provider seems to work
    sudo cp "google.provider" "/usr/share/accounts/providers/kde/google.provider"
    sudo chown root:root "/usr/share/accounts/providers/kde/google.provider"

}

corectrl(){
    ## setup corectrl by running the corectrl.py script
    cd "configs" || exit
    python3 corectrl.py
    sudo cp "90-corectrl.rules" "/etc/polkit-1/rules.d/90-corectrl.rules"
    sudo chown root:root "/etc/polkit-1/rules.d/90-corectrl.rules"

}

game_profiles(){
    if test -f /home/"$USER"/.config/MangoHud/MangoHud.conf; then
        echo "MangoHud.conf exists. Not copying profiles over."
    elif ! test -f /home/"$USER"/.config/MangoHud/MangoHud.conf; then
        mkdir /home/"$USER"/.config/MangoHud/
        git clone https://github.com/Dskobra/game-profiles
        cd game-profiles || exit
        chown "$USER":"$USER" *.conf
        cp *.conf "$HOME"/.config/MangoHud/
    fi
}

security(){
    # https://discussion.fedoraproject.org/t/use-clamdscan-on-workstation-f38/96864/3
    # note not sure why setroubleshoot package isnt preinstalled in fedora 41 kde spin.
    # fedora 40 was preinstalled
    sudo dnf install -y clamav clamav-update clamd setroubleshoot
    sudo sed -i -e "/^#*LocalSocket\s/s/^#//" /etc/clamd.d/scan.conf
    sudo freshclam
    sudo systemctl --now enable clamav-freshclam.service clamd@scan.service
    sudo semanage boolean -m -1 antivirus_can_scan_system
}

if [ "$1" == "grub" ]
then

    grub
elif [ "$1" == "kde_gdrive_fix" ]
then
    kde_gdrive_fix
elif [ "$1" == "corectrl" ]
then
    corectrl
elif [ "$1" == "game_profiles" ]
then
    game_profiles
elif [ "$1" == "security" ]
then
    clamav
else
    echo "error"
fi