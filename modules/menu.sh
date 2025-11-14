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
    echo "(1) Post Install                       (2) Various Fixes"
    echo "(3) Containers"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            setup_menu
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
    echo "(5) Create codecs container            (6) Install apps"
    echo "(m) Main Menu                          (0) Exit"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            #distrobox create --name tooling --image fedora:42 
            "$TOOLS_FOLDER"/modules/containers/containers.sh "tooling"
            ;;

        2)
            "$TOOLS_FOLDER"/modules/containers/tooling.sh
            ;;

        3)
            #distrobox create --name apps --image fedora:42
            "$TOOLS_FOLDER"/modules/containers/containers.sh "apps" 
            ;;

        4)
            "$TOOLS_FOLDER"/modules/containers/apps.sh
            ;;

        5)
            "$TOOLS_FOLDER"/modules/containers/containers.sh "codecs"
            ;;

        6)
            "$TOOLS_FOLDER"/modules/containers/codecs.sh
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
    echo "-------------------------Fedora DNF-------------------------"
    echo "========================================================================="
    echo "(1) Desktop                            (2) Laptop"
    echo "(3) MiniPC"
    echo "========================================================================="
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

        3)
            echo "Disabled"
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
    echo "-------------------------Setup Desktop /w Fedora DNF-------------------------"
    echo "(1) Install CoolerControl         (2) Install packages"
    echo "(3) Setup system"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            sudo dnf copr enable -y codifryed/CoolerControl
            sudo dnf install -y coolercontrol
            sudo systemctl enable --now coolercontrold
            "$TOOLS_FOLDER"/modules/setup/DESKTOP/coolercontrol.sh "fedora"
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
    echo "-------------------------Setup Laptop /w Fedora DNF-------------------------"
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

minipc_fedora_menu(){
    echo "-------------------------Setup Minipc /w Fedora DNF-------------------------"
    echo "(1) Install packages              (2) Setup system"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            "$TOOLS_FOLDER"/modules/setup/MINIPC/install-packages.sh
            ;;

        2)
            "$TOOLS_FOLDER"/modules/setup/MINIPC/configure-system.sh
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
            minipc_fedora_menu
            ;;

        esac
        unset input
        minipc_fedora_menu
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
    echo "(3) MiniPC"
    echo "========================================================================="
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

        3)
            echo "disabled"
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
    echo "        ---Setup DESKTOP /W Tumbleweed---"
    echo "(1) CoolerControl                 (2) Install packages"
    echo "(3) Setup system"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            "$TOOLS_FOLDER"/modules/setup/DESKTOP/coolercontrol.sh "opensuse"
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
    echo "        ---Setup LAPTOP /W Tumbleweed---"
    echo "(1) Nvidia Driver                 (2) Install packages"
    echo "(3) Setup system"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            "$TOOLS_FOLDER"/modules/setup/opensuse/LAPTOP/install-nvidia.sh "opensuse"
            ;;
        2)
            "$TOOLS_FOLDER"/modules/setup/opensuse/shared/install-packages.sh "opensuse"
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

minipc_opensuse_menu(){
    echo "        ---Setup MiniPC /W Tumbleweed---"
    echo "(1) Install packages              (2) Setup system"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            "$TOOLS_FOLDER"/modules/setup/MINIPC/install-packages.sh
            ;;

        2)
            "$TOOLS_FOLDER"/modules/setup/MINIPC/configure-system.sh
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
            minipc_opensuse_menu
            ;;

        esac
        unset input
        minipc_opensuse_menu
}

main_menu
