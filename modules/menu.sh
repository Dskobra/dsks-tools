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
    echo "(1) Desktop /w Fedora                  (2) Desktop /w Fedora Atomic"
    echo "(3) Laptop  /w Fedora                  (4) Laptop  /w Fedora Atomic"
    echo "========================================================================="
    echo "-------------------------Tumbleweed-------------------------"
    echo "(5) Desktop"
    echo "(m) Main Menu                          (0) Exit"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            desktop_reg_fedora_menu
            ;;

        2)
            desktop_atomic_fedora_menu
            ;;

        3)
            laptop_reg_fedora_menu
            ;;

        4)
            laptop_atomic_fedora_menu
            ;;

        5)
            desktop_tumbleweed_menu
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

laptop_atomic_fedora_menu(){
    echo "        ---Setup LAPTOP /W Fedora atomic---"
    echo "(1) Install packages              (2) Setup hardware"
    echo "(3) Setup system                  (4) Setup apps"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            "$TOOLS_FOLDER"/modules/post_install/fedora-atomic/shared/cleanup.sh
            "$TOOLS_FOLDER"/modules/post_install/fedora-atomic/LAPTOP/install_packages.sh
            ;;

        2)
            "$TOOLS_FOLDER"/modules/post_install/fedora-atomic/LAPTOP/configure_hardware.sh
            ;;

        3)
            "$TOOLS_FOLDER"/modules/post_install/fedora-atomic/LAPTOP/configure_system.sh
            ;;

        4)
            "$TOOLS_FOLDER"/modules/post_install/fedora-atomic/LAPTOP/configure_apps.sh
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
            laptop_atomic_fedora_menu
            ;;

        esac
        unset input
        laptop_atomic_fedora_menu
}

# opensuse menus
desktop_tumbleweed_menu(){
    echo "        ---Setup DESKTOP Tumbleweed---"
    echo "(1) Install packages              (2) Setup hardware"
    echo "(3) Setup system                  (4) Setup apps"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            "$TOOLS_FOLDER"/modules/post_install/opensuse/DESKTOP/install_packages.sh
            ;;

        2)
            "$TOOLS_FOLDER"/modules/post_install/opensuse/DESKTOP/configure_hardware.sh
            ;;

        3)
            "$TOOLS_FOLDER"/modules/post_install/opensuse/DESKTOP/configure_system.sh
            ;;

        4)
            echo "Disabled atm"
           # "$TOOLS_FOLDER"/modules/post_install/opensuse/DESKTOP/configure_apps.sh
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
            desktop_tumbleweed_menu
            ;;

        esac
        unset input
        desktop_tumbleweed_menu
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
main_menu
