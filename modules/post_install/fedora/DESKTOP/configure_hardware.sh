#!/usr/bin/bash
configure_boot(){
    sudo sed -i '/GRUB_CMDLINE_LINUX="rhgb quiet"/c GRUB_CMDLINE_LINUX="amd_iommu=on iommu=pt amdgpu.ppfeaturemask=0xffffffff acpi_enforce_resources=lax crashkernel=512M rhgb quiet"' /etc/default/grub
    sudo sed -i '/GRUB_TIMEOUT=5/c GRUB_TIMEOUT=12' /etc/default/grub
    sudo grub2-mkconfig -o /etc/grub2.cfg
}

configure_drives(){
    ## setup drive mount points/permissions
    mkdir /home/jordan/Drives/
    mkdir /home/jordan/Drives/data_drive
    mkdir /home/jordan/Drives/game_drive
    mkdir /home/jordan/Drives/vm_drive
    echo "LABEL=data_drive                               /home/jordan/Drives/data_drive       btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
    echo "LABEL=game_drive                               /home/jordan/Drives/game_drive       btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
    echo "LABEL=vm_drive                                 /home/jordan/Drives/vm_drive         btrfs   nofail,users,exec             0 0"  | sudo tee -a /etc/fstab > /dev/null
    sudo systemctl daemon-reload
    sudo mount -av
}

configure_pcie(){
    echo 'add_driver+=" vfio vfio_iommu_type1 vfio_pci vfio_virqfd "' | sudo tee /etc/dracut.conf.d/local.conf > /dev/null
    sudo chown root:root "/etc/dracut.conf.d/local.conf"
    sudo dracut --regenerate-all --force    # rebuild initramfs for all installed kernels
}

configure_openrgb(){
    # OpenRGB needs a a couple kernel mods loaded
    # for smbus access. So make sure they are
    # automatically loaded on boot
    sudo modprobe i2c-dev
    sudo modprobe i2c-piix4
    sudo touch /etc/modules-load.d/i2c.conf
    sudo sh -c 'echo "i2c-dev" >> /etc/modules-load.d/i2c.conf'
    sudo sh -c 'echo "i2c-piix4" >> /etc/modules-load.d/i2c.conf'
    sudo i2cdetect -l
}
configure_boot
configure_drives
configure_pcie
configure_openrgb
