#!/usr/bin/bash

device_menu(){
    echo "------------------"
    echo "|   Devices      |"
    echo "------------------"
    echo ""
    echo "-------------------------Fedora-------------------------"
    echo "========================================================================="
    echo "(1) Desktop Fedora (non atomic)        (2) Laptop Fedora (non atomic)"
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
            laptop_reg_fedora_menu
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

desktop_reg_fedora_menu(){
    echo "        ---Setup DESKTOP /W Fedora (non atomic)---"
    echo "(1) Install lact                  (2) Install packages"
    echo "(3) Setup system"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            sudo dnf copr enable -y ilyaz/LACT
            sudo dnf install -y lact
            ;;
        2)
            "$TOOLS_FOLDER"/modules/post-install/distro/shared/install_packages.sh
            ;;

        3)
            "$TOOLS_FOLDER"/modules/post-install/distro/DESKTOP/configure_system.sh
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

laptop_reg_fedora_menu(){
    echo "        ---Setup LAPTOP /W Fedora (non atomic)---"
    echo "(1) Nvidia Driver                 (2) Install packages"
    echo "(3) Setup system"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            "$TOOLS_FOLDER"/modules/post-install/distro/LAPTOP/install_nvidia.sh
            ;;
        2)
            "$TOOLS_FOLDER"/modules/post-install/distro/shared/install_packages.sh
            ;;

        3)
            "$TOOLS_FOLDER"/modules/post-install/distro/LAPTOP/configure_system.sh
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
            "$TOOLS_FOLDER"/modules/post-install/distro/MINIPC/install_packages.sh
            ;;

        2)
            "$TOOLS_FOLDER"/modules/post-install/distro/MINIPC/configure_hardware.sh
            ;;

        3)
            "$TOOLS_FOLDER"/modules/post-install/distro/MINIPC/configure_system.sh
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

device_menu
