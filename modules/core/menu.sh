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
    echo "(3) Containers                         (4) Game profiles"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            post_menu
            ;;

        2)
            fixes_menu
            ;;

        3)
            containers_menu
            ;;

        4)
            "$TOOLS_FOLDER"/modules/core/branch-puller.sh "game-profiles"
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

post_menu(){
    echo "------------------"
    echo "|  Post install  |"
    echo "------------------"
    echo ""
    echo "(1) Fedora DNF                         (2) Fedora Ostree"
    echo "(3) openSUSE Tumbleweed"
    echo "(m) Main Menu                          (0) Exit"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            fedora_dnf_menu
            ;;

        2)
            fedora_ostree_menu
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
            post_menu
            ;;

        esac
        unset input
        post_menu
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
fedora_dnf_menu(){
    echo "------------------"
    echo "|   Devices      |"
    echo "------------------"
    echo ""
    echo "-------------------------Fedora DNF-------------------------"
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
            desktop_fedora_dnf_menu
            ;;

        2)
            laptop_fedora_dnf_menu
            ;;

        3)
            minipc
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
        fedora_dnf_menu
}

desktop_fedora_dnf_menu(){
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
            ;;
        2)
            "$TOOLS_FOLDER"/modules/post-install/install-packages.sh "fedora-dnf"
            ;;

        3)
            DISTRO="fedora-dnf"
            "$TOOLS_FOLDER"/modules/post-install/fedora/DESKTOP/configure-system.sh "fedora-dnf"
            "$TOOLS_FOLDER"/modules/post-install/configure-system.sh "fedora-dnf"
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
            desktop_fedora_dnf_menu
            ;;

        esac
        unset input
        desktop_fedora_dnf_menu
}

laptop_fedora_dnf_menu(){
    echo "-------------------------Setup Laptop /w Fedora DNF-------------------------"
    echo "(1) Nvidia Driver                 (2) Install packages"
    echo "(3) Setup system"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            "$TOOLS_FOLDER"/modules/post-install/fedora/LAPTOP/install-nvidia.sh "fedora-dnf"
            ;;
        2)
            "$TOOLS_FOLDER"/modules/post-install/fedora/install-packages.sh "fedora-dnf"
            ;;

        3)
            DISTRO="fedora-dnf"
            "$TOOLS_FOLDER"/modules/post-install/fedora/LAPTOP/configure-system.sh 
            "$TOOLS_FOLDER"/modules/post-install/fedora/configure-system.sh "fedora-dnf"
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
            laptop_fedora_dnf_menu
            ;;

        esac
        unset input
        laptop_fedora_dnf_menu
}

minipc_fedora_dnf_menu(){
    echo "-------------------------Setup Minipc /w Fedora DNF-------------------------"
    echo "(1) Install packages              (2) Setup hardware"
    echo "(3) Setup system"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            "$TOOLS_FOLDER"/modules/post-install/fedora/MINIPC/install-packages.sh
            ;;

        2)
            "$TOOLS_FOLDER"/modules/post-install/fedora/MINIPC/configure-hardware.sh
            ;;

        3)
            "$TOOLS_FOLDER"/modules/post-install/fedora/MINIPC/configure-system.sh
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
            minipc_fedora_dnf_menu
            ;;

        esac
        unset input
        minipc_fedora_dnf_menu
}

fedora_ostree_menu(){
    echo "------------------"
    echo "|   Devices      |"
    echo "------------------"
    echo ""
    echo "-------------------------Fedora ostree-------------------------"
    echo "========================================================================="
    echo "(1) Desktop Fedora Atomic              (2) Laptop Fedora Atomic"
    echo "========================================================================="
    echo "(m) Main Menu                          (0) Exit"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            desktop_fedora_ostree_menu
            ;;

        2)
            laptop_fedora_ostree_menu
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
            fedora_ostree_menu
            ;;

        esac
        unset input
        fedora_ostree_menu
}

desktop_fedora_ostree_menu(){
    echo "-------------------------Setup Desktop /w Fedora Ostree-------------------------"
    echo "(1) CoolerControl                 (2) Install packages"
    echo "(3) Setup system"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            "$TOOLS_FOLDER"/modules/post-install/fedora/DESKTOP/coolercontrol.sh "fedora-ostree"
            ;;


        2)
            "$TOOLS_FOLDER"/modules/post-install/fedora/cleanup-atomic.sh
            "$TOOLS_FOLDER"/modules/post-install/fedora/install-packages.sh "fedora-ostree"
            ;;

        3)
            DISTRO="ostree"
            "$TOOLS_FOLDER"/modules/post-install/fedora/DESKTOP/configure-system.sh "fedora-ostree"
            "$TOOLS_FOLDER"/modules/post-install/fedora/shared/configure-system.sh "fedora-ostree"
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
            desktop_fedora_ostree_menu
            ;;

        esac
        unset input
        desktop_fedora_ostree_menu
}

laptop_fedora_ostree_menu(){
    echo "-------------------------Setup Laptop /w Fedora Ostree-------------------------"
    echo "(1) Nvidia Driver                 (2) Install packages"
    echo "(3) Setup system"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            "$TOOLS_FOLDER"/modules/post-install/fedora/LAPTOP/install-nvidia.sh "fedora-ostree"
            ;;

        2)
            "$TOOLS_FOLDER"/modules/post-install/fedora/cleanup-atomic.sh
            "$TOOLS_FOLDER"/modules/post-install/fedora/install-packages.sh "fedora-ostree"
            ;;

        3)
            DISTRO="ostree"
            "$TOOLS_FOLDER"/modules/post-install/fedora/configure-system.sh "fedora-ostree"
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
            laptop_fedora_ostree_menu
            ;;

        esac
        unset input
        laptop_fedora_ostree_menu
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
    echo "(4) MiniPC"
    echo "========================================================================="
    echo "(m) Main Menu                          (0) Exit"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            desktop_opensuse
            ;;

        2)
            laptop_opensuse
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

desktop_opensuse(){
    echo "        ---Setup DESKTOP /W Tumbleweed---"
    echo "(1) Install packages              (2) Setup system"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            "$TOOLS_FOLDER"/modules/post-install/opensuse/shared/install-packages.sh
            ;;

        2)
            "$TOOLS_FOLDER"/modules/post-install/opensuse/DESKTOP/configure-system.sh
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
            desktop_opensuse
            ;;

        esac
        unset input
        desktop_opensuse
}

laptop_opensuse(){
    echo "        ---Setup LAPTOP /W Tumbleweed---"
    echo "(1) Nvidia Driver                 (2) Install packages"
    echo "(3) Setup system"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            "$TOOLS_FOLDER"/modules/post-install/opensuse/LAPTOP/install-nvidia.sh
            ;;
        2)
            "$TOOLS_FOLDER"/modules/post-install/opensuse/shared/install-packages.sh
            ;;

        3)
            "$TOOLS_FOLDER"/modules/post-install/opensuse/LAPTOP/configure-system.sh
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
            laptop_opensuse
            ;;

        esac
        unset input
        laptop_opensuse
}

minipc_opensuse(){
    echo "        ---Setup MiniPC /W Tumbleweed---"
    echo "(1) Install packages              (2) Setup hardware"
    echo "(3) Setup system"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            "$TOOLS_FOLDER"/modules/post-install/opensuse/MINIPC/install-packages.sh
            ;;

        2)
            "$TOOLS_FOLDER"/modules/post-install/opensuse/MINIPC/configure-hardware.sh
            ;;

        3)
            "$TOOLS_FOLDER"/modules/post-install/opensuse/MINIPC/configure-system.sh
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
            minipc_opensuse
            ;;

        esac
        unset input
        minipc_opensuse
}

main_menu
