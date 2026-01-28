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
            new_menu
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

new_menu(){
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
            new_menu
            ;;

        esac
        unset input
        new_menu
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

################################
### section for Fedora device 
### menus
################################
fedora_menu(){
    echo "------------------"
    echo "|   Devices      |"
    echo "------------------"
    echo ""
    echo "-------------------------Fedora-------------------------"
    echo "========================================================================="
    echo "(1) Desktop                            (2) Laptop"
    echo "(m) Main Menu                          (0) Exit"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            desktop_fedora_menu
            ;;

        2)
            laptop_fedora_menu
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
            fedora_dnf_menu
            ;;

        esac
        unset input
        fedora_menu
}

desktop_fedora_menu(){
    echo "-------------------------Setup Desktop /w Fedora-------------------------"
    echo "(1) Install Lact                  (2) Install packages"
    echo "(3) Setup system"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            "$TOOLS_FOLDER"/modules/setup/DESKTOP/lact.sh "fedora"
            ;;
        2)
            "$TOOLS_FOLDER"/modules/setup/install-packages.sh "fedora"
            ;;

        3)
            "$TOOLS_FOLDER"/modules/setup/DESKTOP/configure-system.sh "fedora"
            "$TOOLS_FOLDER"/modules/setup/configure-system.sh "fedora"
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
            desktop_fedora_menu
            ;;

        esac
        unset input
        desktop_fedora_menu
}

laptop_fedora_menu(){
    echo "-------------------------Setup Laptop /w Fedora-------------------------"
    echo "(1) Nvidia Driver                 (2) Install packages"
    echo "(3) Setup system"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            "$TOOLS_FOLDER"/modules/setup/LAPTOP/install-nvidia.sh "fedora"
            ;;
        2)
            "$TOOLS_FOLDER"/modules/setup/install-packages.sh "fedora"
            ;;

        3)
            "$TOOLS_FOLDER"/modules/setup/LAPTOP/configure-system.sh  "fedora"
            "$TOOLS_FOLDER"/modules/setup/configure-system.sh "fedora"
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
            laptop_fedora_menu
            ;;

        esac
        unset input
        laptop_fedora_menu
}

################################
### end section
################################



main_menu
