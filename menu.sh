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
    echo "(1) Setup                              (2) Various Fixes"
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

setup_menu(){
    echo "------------------"
    echo "|  Post install  |"
    echo "------------------"
    echo ""
    echo "(1) Fedora                             (2) openSUSE Tumbleweed"
    echo "(m) Main Menu                          (0) Exit"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            fedora_menu
            ;;

        2)
            opensuse_menu
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
            setup_menu
            ;;

        esac
        unset input
        setup_menu
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

################################
### section for openSUSE device 
### menus
################################
opensuse_menu(){
    echo "------------------"
    echo "|   Devices      |"
    echo "------------------"
    echo ""
    echo "-------------------------openSUSE Tumbleweed-------------------------"
    echo "========================================================================="
    echo "(1) Desktop                            (2) Laptop"
    echo "(m) Main Menu                          (0) Exit"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            desktop_opensuse_menu
            ;;

        2)
            laptop_opensuse_menu
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
            opensuse_menu
            ;;

        esac
        unset input
        opensuse_menu
}

desktop_opensuse_menu(){
    echo "        ---Setup DESKTOP /w Tumbleweed---"
    echo "(1) install Lact                  (2) Install packages"
    echo "(3) Setup system"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            "$TOOLS_FOLDER"/modules/setup/DESKTOP/lact.sh "opensuse"
            ;;

        2)
            "$TOOLS_FOLDER"/modules/setup/install-packages.sh "opensuse"
            ;;

        3)
            "$TOOLS_FOLDER"/modules/setup/DESKTOP/configure-system.sh "opensuse"
            "$TOOLS_FOLDER"/modules/setup/configure-system.sh "opensuse"
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
            desktop_opensuse_menu
            ;;

        esac
        unset input
        desktop_opensuse_menu
}

laptop_opensuse_menu(){
    echo "        ---Setup LAPTOP /w Tumbleweed---"
    echo "(1) Nvidia Driver                 (2) Install packages"
    echo "(3) Setup system"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            "$TOOLS_FOLDER"/modules/setup/LAPTOP/install-nvidia.sh "opensuse"
            ;;
        2)
            "$TOOLS_FOLDER"/modules/setup/install-packages.sh "opensuse"
            ;;

        3)
            "$TOOLS_FOLDER"/modules/setup/LAPTOP/configure-system.sh "opensuse"
            "$TOOLS_FOLDER"/modules/setup/configure-system.sh "opensuse"
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
            laptop_opensuse_menu
            ;;

        esac
        unset input
        laptop_opensuse_menu
}

new_menu(){
    echo "        ---Setup DESKTOP---"
    echo "(1) install Lact                  (2) Nvidia Driver"
    echo "(3) Install packages              "
    echo "(4) Configure Desktop             (5) Configure Laptop"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            "$TOOLS_FOLDER"/devices/drivers.sh "$DISTRO" "lact"
            ;;

        2)
            "$TOOLS_FOLDER"/modules/setup/install-packages.sh "opensuse"
            ;;

        3)
            "$TOOLS_FOLDER"/modules/setup/DESKTOP/configure-system.sh "opensuse"
            "$TOOLS_FOLDER"/modules/setup/configure-system.sh "opensuse"
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

main_menu
