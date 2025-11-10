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
    echo "(1) Fedora                             (2) Fedora Atomic"
    echo "(3) openSUSE Tumbleweed"
    echo "(m) Main Menu                          (0) Exit"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            fedora_menu
            ;;

        2)
            atomic_menu
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
### section for Fedora
################################
fedora_menu(){
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
            desktop_reg_fedora
            ;;

        2)
            laptop_reg_fedora
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
            fedora_menu
            ;;

        esac
        unset input
        fedora_menu
}

desktop_reg_fedora(){
    echo "        ---Setup DESKTOP /W Fedora (non atomic)---"
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
            "$TOOLS_FOLDER"/modules/post-install/fedora/shared/install-packages.sh "fedora"
            ;;

        3)
            "$TOOLS_FOLDER"/modules/post-install/fedora/DESKTOP/configure-system.sh "fedora"
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
            desktop_reg_fedora
            ;;

        esac
        unset input
        desktop_reg_fedora
}

laptop_reg_fedora(){
    echo "        ---Setup LAPTOP /W Fedora (non atomic)---"
    echo "(1) Nvidia Driver                 (2) Install packages"
    echo "(3) Setup system"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            "$TOOLS_FOLDER"/modules/post-install/fedora/LAPTOP/install-nvidia.sh
            ;;
        2)
            "$TOOLS_FOLDER"/modules/post-install/fedora/shared/install-packages.sh "fedora"
            ;;

        3)
            "$TOOLS_FOLDER"/modules/post-install/fedora/LAPTOP/configure-system.sh "fedora"
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
            laptop_reg_fedora
            ;;

        esac
        unset input
        laptop_reg_fedora
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
            minipc
            ;;

        esac
        unset input
        minipc
}

atomic_menu(){
    echo "------------------"
    echo "|   Devices      |"
    echo "------------------"
    echo ""
    echo "-------------------------Fedora atomic-------------------------"
    echo "========================================================================="
    echo "(1) Desktop Fedora Atomic              (2) Laptop Fedora Atomic"
    echo "========================================================================="
    echo "(m) Main Menu                          (0) Exit"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            desktop_atomic_menu
            ;;

        2)
            laptop_atomic_menu
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
            atomic_menu
            ;;

        esac
        unset input
        atomic_menu
}

desktop_atomic_menu(){
    echo "        ---Setup DESKTOP /W Fedora atomic---"
    echo "(1) Lact                          (2) Install packages"
    echo "(3) Setup system"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
            flatpak install --user -y flathub io.github.ilya_zlobintsev.LACT
            ;;


        2)
            "$TOOLS_FOLDER"/modules/post-install/fedora/shared/cleanup-atomic.sh
            "$TOOLS_FOLDER"/modules/post-install/fedora/shared/install-packages.sh "fedora-atomic"
            ;;

        3)
            "$TOOLS_FOLDER"/modules/post-install/fedora/DESKTOP/configure-system.sh "fedora-atomic"
            "$TOOLS_FOLDER"/modules/post-install/fedora/shared/configure-system.sh "fedora-atomic"
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
            desktop_atomic_menu
            ;;

        esac
        unset input
        desktop_atomic_menu
}

laptop_atomic_menu(){
    echo "        ---Setup LAPTOP /W Fedora atomic---"
    echo "(1) Nvidia Driver                 (2) Install packages"
    echo "(3) Setup system"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
            "$TOOLS_FOLDER"/modules/post-install/fedora/LAPTOP/install-atomic-nvidia.sh
            ;;

        2)
            "$TOOLS_FOLDER"/modules/post-install/fedora/shared/cleanup-atomic.sh
            "$TOOLS_FOLDER"/modules/post-install/fedora/shared/install-packages.sh "fedora-atomic"
            ;;

        3)
            "$TOOLS_FOLDER"/modules/post-install/fedora/DESKTOP/configure-system.sh "fedora-atomic"
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
            laptop_atomic_menu
            ;;

        esac
        unset input
        laptop_atomic_menu
}
################################
### end section
################################
main_menu
