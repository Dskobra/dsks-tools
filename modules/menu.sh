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
    echo "(1) Device_menu                        (2) Various Fixes"
    echo "(3) Containers"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            device_menu
            ;;

        2)
            fixes_menu
            ;;

        3)
            experiments_menu
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

device_menu(){
    echo "------------------"
    echo "|   Devices      |"
    echo "------------------"
    echo ""
    echo "-------------------------Fedora-------------------------"
    echo "========================================================================="
    echo "(1) Desktop Fedora (non atomic)        (2) Desktop Fedora Atomic "
    echo "(3) Laptop Fedora (non atomic)"
    echo "(4) MiniPC"
    echo "========================================================================="
    echo "(m) Main Menu                          (0) Exit"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            desktop_reg_fedora_menu
            ;;

        2)
            echo "disabled. needs cleanup"
            #desktop_atomic_fedora_menu
            ;;

        3)
            laptop_reg_fedora_menu
            ;;

        4)
            echo "Disabled atm"
            ;;

        m | M)
            main_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            device_menu
            ;;

        esac
        unset input
        device_menu
}

# fedora menus
desktop_reg_fedora_menu(){
    echo "        ---Setup DESKTOP /W Fedora (non atomic)---"
    echo "(1) Install packages              (2) Setup hardware"
    echo "(3) Setup system                  (4) Setup apps"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            "$TOOLS_FOLDER"/modules/post_install/fedora/DESKTOP/install_packages.sh
            ;;

        2)
            "$TOOLS_FOLDER"/modules/post_install/fedora/DESKTOP/configure_hardware.sh
            ;;

        3)
            "$TOOLS_FOLDER"/modules/post_install/fedora/DESKTOP/configure_system.sh
            ;;

        4)
            "$TOOLS_FOLDER"/modules/post_install/fedora/DESKTOP/configure_apps.sh
            ;;


        m | M )
            main_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            desktop_reg_fedora_menu
            ;;

        esac
        unset input
        desktop_reg_fedora_menu
}

desktop_atomic_fedora_menu(){
    echo "        ---Setup DESKTOP /W Fedora atomic---"
    echo "(1) Install packages              (2) Setup hardware"
    echo "(3) Setup system                  (4) Setup apps"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            "$TOOLS_FOLDER"/modules/post_install/fedora-atomic/shared/cleanup.sh
            "$TOOLS_FOLDER"/modules/post_install/fedora-atomic/DESKTOP/install_packages.sh
            ;;

        2)
            "$TOOLS_FOLDER"/modules/post_install/fedora-atomic/DESKTOP/configure_hardware.sh
            ;;

        3)
            "$TOOLS_FOLDER"/modules/post_install/fedora-atomic/DESKTOP/configure_system.sh
            ;;

        4)
            "$TOOLS_FOLDER"/modules/post_install/fedora-atomic/DESKTOP/configure_apps.sh
            ;;

        m | M )
            main_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            desktop_atomic_fedora_menu
            ;;

        esac
        unset input
        desktop_atomic_fedora_menu
}

laptop_reg_fedora_menu(){
    echo "        ---Setup LAPTOP /W Fedora (non atomic)---"
    echo "(1) Install packages              (2) Setup hardware"
    echo "(3) Setup system                  (4) Setup apps"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            "$TOOLS_FOLDER"/modules/post_install/fedora/LAPTOP/install_packages.sh
            ;;

        2)
            "$TOOLS_FOLDER"/modules/post_install/fedora/LAPTOP/configure_hardware.sh
            ;;

        3)
            "$TOOLS_FOLDER"/modules/post_install/fedora/LAPTOP/configure_system.sh
            ;;

        4)
            "$TOOLS_FOLDER"/modules/post_install/fedora/LAPTOP/configure_apps.sh
            ;;

        m | M )
            main_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            laptop_reg_fedora_menu
            ;;

        esac
        unset input
        laptop_reg_fedora_menu
}

minipc_reg_fedora_menu(){
    echo "        ---Setup MiniPC /W Fedora (non atomic)---"
    echo "(1) Install packages              (2) Setup hardware"
    echo "(3) Setup system"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            "$TOOLS_FOLDER"/modules/post_install/fedora/MINIPC/install_packages.sh
            ;;

        2)
            "$TOOLS_FOLDER"/modules/post_install/fedora/MINIPC/configure_hardware.sh
            ;;

        3)
            "$TOOLS_FOLDER"/modules/post_install/fedora/MINIPC/configure_system.sh
            ;;

        m | M )
            main_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            minipc_reg_fedora_menu
            ;;

        esac
        unset input
        minipc_reg_fedora_menu
}

# misc
fixes_menu(){
    echo "(1) Nvidia gsk fix                (2) Steam launch fix"
    echo "(3) Remove RPMFusion"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            "$TOOLS_FOLDER"/modules/fixes/nvidia.sh
            ;;

        2)
            "$TOOLS_FOLDER"/modules/fixes/steam.sh
            ;;

        3)
            "$TOOLS_FOLDER"/modules/fixes/rpmfusion.sh
            ;;

        m | M)
            main_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            fixes_menu
            ;;

        esac
        unset input
        fixes_menu
}

containers_menu(){
    echo "------------------"
    echo "|  Containers    |"
    echo "------------------"
    echo ""
    echo "(1) Create dev container               (2) Install tools"
    echo "(3) Create apps container              (4) Install apps"
    echo "(m) Main Menu                          (0) Exit"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            distrobox create --image fedora:42 --name tooling
            ;;

        2)
            "$TOOLS_FOLDER"/modules/containers/tooling.sh
            ;;

        m | M)
            main_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            containers_menu
            ;;

        esac
        unset input
        containers_menu
}

main_menu
