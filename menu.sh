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
    echo "(1) Devices                           (2) Various Fixes"
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
            containers_menu
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
    echo "(1) Install Lact                  (2) Install Nvidia Driver"
    echo "(3) Install packages              "
    echo "(4) Configure Desktop             (5) Configure Laptop"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            "$TOOLS_FOLDER"/devices/drivers.sh "lact" "$DISTRO" 
            ;;

        2)
            "$TOOLS_FOLDER"/devices/drivers.sh "nvidia" "$DISTRO" 
            ;;

        3)
            "$TOOLS_FOLDER"/devices/packages.sh "$DISTRO"
            ;;

        4)
            "$TOOLS_FOLDER"/devices/desktop.sh 
            "$TOOLS_FOLDER"/devices/system.sh
            ;;

        5)
            "$TOOLS_FOLDER"/devices/laptop.sh 
            "$TOOLS_FOLDER"/devices/system.sh
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
            device_menu
            ;;

        esac
        unset input
        device_menu
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
    echo "(1) Create dev container               (2) Install apps"
    echo "(3) Create apps container              (4) Install apps"
    echo "(m) Main Menu                          (0) Exit"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            "$TOOLS_FOLDER"/modules/containers/create.sh "tooling"
            ;;

        2)
            "$TOOLS_FOLDER"/modules/containers/tooling.sh
            ;;

        3)
            "$TOOLS_FOLDER"/modules/containers/create.sh "apps" 
            ;;

        4)
            "$TOOLS_FOLDER"/modules/containers/apps.sh
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
