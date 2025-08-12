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
    echo "(1) Post Install                       (2) Various fixes"
    echo "(3) Desktop /w Fedora                  (4) Desktop /w Fedora Atomic"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            post_install
            ;;
        2)
            fixes_menu
            ;;

        3)
            desktop_reg_fedora_menu
            ;;

        4)
            atomic_desktop_menu
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

desktop_reg_fedora_menu(){
    echo "        ---Setup DESKTOP /W Fedora (non atomic)--"
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
}

desktop_atomic_fedora_menu(){
    echo "        ---Setup DESKTOP /W Fedora atomic--"
    echo "(1) Install packages              (2) Setup hardware"
    echo "(3) Setup system                  (4) Setup apps"
    echo "(5) Ossec"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            "$TOOLS_FOLDER"/modules/post_install/fedora-atomic/DESKTOP/cleanup.sh
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

        5)
            "$TOOLS_FOLDER"/modules/post_install/fedora-atomic/DESKTOP/ossec.sh
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
}

laptop_reg_fedora_menu(){
    echo "        ---Setup LAPTOP /W Fedora (non atomic)--"
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
}

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

        9)
            post_menu
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

post_install(){
    DISTRO=$(source /etc/os-release ; echo $ID)
    PCNAME=$(hostname)
    "$TOOLS_FOLDER"/modules/post_install/"$DISTRO"/"$PCNAME"/setup.sh
}
main_menu
