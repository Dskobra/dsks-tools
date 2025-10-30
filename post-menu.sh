#!/usr/bin/bash

device_menu(){
    echo "------------------"
    echo "|   Devices      |"
    echo "------------------"
    echo ""
    echo "-------------------------Fedora (non atomic)-------------------------"
    echo "========================================================================="
    echo "(1) Desktop                            (2) Laptop"
    echo "(4) MiniPC"
    echo "========================================================================="
    echo "(m) Main Menu                          (0) Exit"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            desktop
            ;;

        2)
            laptop
            ;;

        3)
            minipc
            ;;

        m | M)
            "$TOOLS_FOLDER"/modules/menu.sh
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

desktop(){
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
            "$TOOLS_FOLDER"/modules/menu.sh
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            desktop
            ;;

        esac
        unset input
        desktop
}

laptop(){
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
            "$TOOLS_FOLDER"/modules/menu.sh
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            laptop
            ;;

        esac
        unset input
        laptop
}

minipc(){
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
            "$TOOLS_FOLDER"/modules/menu.sh
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            minipc
            ;;

        esac
        unset input
        minipc
}

device_menu
