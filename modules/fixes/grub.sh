#!/usr/bin/bash
amd_grub(){
    # backup the default fedora provided grub
    sudo mv "/etc/default/grub" "/etc/default/grub.default.bak"

    # copy my custom grub configuration into folder
    cd "$TOOLS_FOLDER"/modules/configs || exit
    sudo cp "amd_grub" "/etc/default/grub"

    # set root as owner
    sudo chown root:root "/etc/default/grub"

    # rebuild grub with the new changes
    sudo grub2-mkconfig -o /etc/grub2.cfg

    #sudo grubby --update-kernel=ALL --args='amd_iommu=on iommu=pt amdgpu.ppfeaturemask=0xffffffff acpi_enforce_resources=lax rhgb quiet'
}

nvidia_grub(){
    # backup the default fedora provided grub
    sudo mv "/etc/default/grub" "/etc/default/grub.default.bak"

    # copy my custom grub configuration into folder
    cd "$TOOLS_FOLDER"/modules/configs || exit
    sudo cp "nvidia_grub" "/etc/default/grub"


    # set root as owner
    sudo chown root:root "/etc/default/grub"

    # rebuild grub with the new changes
    sudo grub2-mkconfig -o /etc/grub2.cfg

    #sudo grubby --update-kernel=ALL --args='amd_iommu=on iommu=pt  rd.driver.blacklist=nouveau modprobe.blacklist=nouveau nvidia-drm.modeset acpi_enforce_resources=lax rhgb quiet'

}

if [ "$1" == "amd_grub" ]
then
    amd_grub
elif [ "$1" == "nvidia_grub" ]
then
    nvidia_grub
else
    echo "error"
fi
