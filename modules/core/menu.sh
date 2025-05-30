#!/usr/bin/bash

main_menu(){
    echo "------------------"   
    echo "|   DSK's Tools  |"
    echo "------------------" 
    echo ""
    echo "$COPYRIGHT"
    echo "Released under the MIT license"
    echo ""
    echo ""
    echo "(1) Setup Grub                     (2) Setup Corectrl"
    echo "(3) Game Profiles                  (4) Setup zram"
    echo "(5) Nvidia gsk fix                 (6) Steam launch fix"
    echo "(7) Setup clamav                   (8) Remove rpmfusion"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            grub_menu
            ;;

        2)
            "$TOOLS_FOLDER"/modules/core/conf.sh "corectrl"
            ;;
        
        3)  
            "$TOOLS_FOLDER"/modules/core/conf.sh "game_profiles"
            ;;

        4)
            "$TOOLS_FOLDER"/modules/core/conf.sh "setup_zram"
            ;;

        5)
            "$TOOLS_FOLDER"/modules/core/conf.sh "nvidia_fix"
            ;;

        6)
            "$TOOLS_FOLDER"/modules/core/conf.sh "steam_launch"
            ;;

        7)
            "$TOOLS_FOLDER"/modules/core/conf.sh "clamav"
            ;;

        8)
            "$TOOLS_FOLDER"/modules/fixes/rpmfusion.sh
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            main_menu
            ;;

        esac
        unset input
        main_menu
}
grub_menu(){
    echo "(1) AMD                           (2) NVIDIA"    
    echo "(m) Main Menu                     (0) Exit"    
    printf "Option: "
    read -r input

    case $input in


        1)
            #sudo grubby --update-kernel=ALL --args='amd_iommu=on iommu=pt amdgpu.ppfeaturemask=0xffffffff acpi_enforce_resources=lax rhgb quiet'
            "$TOOLS_FOLDER"/modules/fixes/grub.sh "amd_grub"
            ;;

        2)
            #sudo grubby --update-kernel=ALL --args='amd_iommu=on iommu=pt  rd.driver.blacklist=nouveau modprobe.blacklist=nouveau nvidia-drm.modeset acpi_enforce_resources=lax rhgb quiet'
            "$TOOLS_FOLDER"/modules/fixes/grub.sh "nvidia_grub"
            ;;

        m)
            main_menu
            ;;

        M)
            main_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            grub_menu
            ;;

        esac
        unset input
}

main_menu
