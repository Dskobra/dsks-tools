#!/usr/bin/bash




if [ "$1" == "fedora-dnf" ]
then
    configure_dnf_system
    configure_system
    personalize_desktop
    flatpak_overrides
    sudo dracut --regenerate-all --force    # rebuild initramfs for all installed kernels
elif [ "$1" == "fedora-ostree" ]
then
    configure_ostree_system_settings
    hide_firefox_from_desktop
    configure_system
    personalize_desktop
    flatpak_overrides
else
    echo "error"
fi
