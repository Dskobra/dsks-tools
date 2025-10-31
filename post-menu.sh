#!/usr/bin/bash

device_menu(){
    echo "------------------"
    echo "|   Devices      |"
    echo "------------------"
    echo ""
    echo "-------------------------Fedora-------------------------"
    echo "========================================================================="
    echo "(1) Desktop Fedora (non atomic)        (2) Desktop Fedora Atomic "
    echo "(3) Laptop Fedora (non atomic)         (4) Laptop Fedora Atomic"
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
            desktop_menu
            ;;

        3)
            laptop_reg_fedora_menu
            ;;

        4)
            laptop_menu
            ;;

        m | M)
            "$TOOLS_FOLDER"/modules/core/menu.sh
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

desktop_menu(){
    echo "        ---Setup DESKTOP /W Fedora atomic---"
    echo "(1) Install packages              (2) Setup hardware"
    echo "(3) Setup system"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            "$TOOLS_FOLDER"/modules/post-install/distro/shared/cleanup.sh
            "$TOOLS_FOLDER"/modules/post-install/distro/DESKTOP/install_packages.sh
            ;;

        2)
            "$TOOLS_FOLDER"/modules/post-install/distro/shared/configure_hardware.sh
            ;;

        3)
            "$TOOLS_FOLDER"/modules/post-install/distro/shared/configure_system.sh
            "$TOOLS_FOLDER"/modules/post-install/distro/DESKTOP/configure_system.sh
            ;;

        m | M )
            "$TOOLS_FOLDER"/modules/core/menu.sh
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            desktop_menu
            ;;

        esac
        unset input
        desktop_menu
}

laptop_menu(){
    echo "        ---Setup LAPTOP /W Fedora atomic---"
    echo "(1) Install packages              (2) Setup hardware"
    echo "(3) Setup system"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            "$TOOLS_FOLDER"/modules/post-install/distro/shared/cleanup.sh
            "$TOOLS_FOLDER"/modules/post-install/distro/LAPTOP/install_packages.sh
            ;;

        2)
            "$TOOLS_FOLDER"/modules/post-install/distro/shared/configure_hardware.sh
            ;;

        3)
            "$TOOLS_FOLDER"/modules/post-install/distro/LAPTOP/configure_system.sh
            ;;

        m | M )
            "$TOOLS_FOLDER"/modules/core/menu.sh
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            laptop_menu
            ;;

        esac
        unset input
        laptop_menu
}

device_menu
