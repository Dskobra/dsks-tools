old_grub(){
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

grub(){
    echo "(1) AMD                    (2) NVIDIA"      
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            sudo grubby --update-kernel=ALL --args='amd_iommu=on iommu=pt amdgpu.ppfeaturemask=0xffffffff acpi_enforce_resources=lax rhgb quiet'
            ;;

        2)
            sudo grubby --update-kernel=ALL --args='amd_iommu=on iommu=pt  rd.driver.blacklist=nouveau modprobe.blacklist=nouveau nvidia-drm.modeset acpi_enforce_resources=lax rhgb quiet'
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            grub
            ;;

        esac
        unset input
}

corectrl(){
    ## setup corectrl by running the corectrl.py script
    cd "configs" || exit
    python3 corectrl.py
    sudo cp "90-corectrl.rules" "/etc/polkit-1/rules.d/90-corectrl.rules"
    sudo chown root:root "/etc/polkit-1/rules.d/90-corectrl.rules"

}

game_profiles(){
        git clone https://github.com/Dskobra/game-profiles
        cd game-profiles || exit
        ./install.sh
    fi
}

security(){
    # https://discussion.fedoraproject.org/t/use-clamdscan-on-workstation-f38/96864/3
    # note not sure why setroubleshoot package isnt preinstalled in fedora 41 kde spin.
    # fedora 40 was preinstalled
    sudo dnf install -y clamav clamav-update clamd #setroubleshoot
    sudo sed -i -e "/^#*LocalSocket\s/s/^#//" /etc/clamd.d/scan.conf
    sudo freshclam
    sudo systemctl --now enable clamav-freshclam.service clamd@scan.service
    sudo semanage boolean -m -1 antivirus_can_scan_system
}

nvidia_fix(){
    # this fixes an issue with wayland/x11 where an application fails to launch
    # with a protocol dispatching to wayland error
    mkdir /home/$USER/.config/environment.d
    echo "GSK_RENDERER=gl" > /home/$USER/.config/environment.d/gsk.conf
}

if [ "$1" == "grub" ]
then
    grub
elif [ "$1" == "corectrl" ]
then
    corectrl
elif [ "$1" == "game_profiles" ]
then
    game_profiles
elif [ "$1" == "security" ]
then
    security
elif [ "$1" == "nvidia_fix" ]
then
    nvidia_fix
else
    echo "error"
fi