#!/usr/bin/bash

tumbleweed_menu(){
    echo "------------------"
    echo "|   Devices      |"
    echo "------------------"
    echo ""
    echo "-------------------------OpenSUSE Tumbleweed-------------------------"
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
            desktop_tumbleweed
            ;;

        2)
            laptop_tumbleweed
            ;;

        3)
            #minipc
            echo "disabled"
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
            tumbleweed_menu
            ;;

        esac
        unset input
        tumbleweed_menu
}

desktop_tumbleweed(){
    echo "        ---Setup DESKTOP /W Tumbleweed---"
    echo "(1) Install packages              (2) Setup system"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            "$TOOLS_FOLDER"/modules/post-install/distro/shared/install-packages.sh
            ;;

        2)
            "$TOOLS_FOLDER"/modules/post-install/distro/DESKTOP/configure-system.sh
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
            desktop_tumbleweed
            ;;

        esac
        unset input
        desktop_tumbleweed
}

laptop_tumbleweed(){
    echo "        ---Setup LAPTOP /W Tumbleweed---"
    echo "(1) Nvidia Driver                 (2) Install packages"
    echo "(3) Setup system"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            "$TOOLS_FOLDER"/modules/post-install/distro/LAPTOP/install-nvidia.sh
            ;;
        2)
            "$TOOLS_FOLDER"/modules/post-install/distro/shared/install-packages.sh
            ;;

        3)
            "$TOOLS_FOLDER"/modules/post-install/distro/LAPTOP/configure-system.sh
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
            laptop_tumbleweed
            ;;

        esac
        unset input
        laptop_tumbleweed
}

minipc(){
    echo "        ---Setup MiniPC /W Tumbleweed---"
    echo "(1) Install packages              (2) Setup hardware"
    echo "(3) Setup system"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            "$TOOLS_FOLDER"/modules/post-install/distro/MINIPC/install-packages.sh
            ;;

        2)
            "$TOOLS_FOLDER"/modules/post-install/distro/MINIPC/configure-hardware.sh
            ;;

        3)
            "$TOOLS_FOLDER"/modules/post-install/distro/MINIPC/configure-system.sh
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
            minipc
            ;;

        esac
        unset input
        minipc
}

if [ "$1" == "opensuse" ]
then
    tumbleweed_menu
else
    echo "error"
fi
