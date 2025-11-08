#!/usr/bin/bash

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
            "$TOOLS_FOLDER"/modules/core/menu.sh
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
            "$TOOLS_FOLDER"/modules/post-install/distro/shared/install-packages.sh "nonatomic"
            ;;

        3)
            "$TOOLS_FOLDER"/modules/post-install/distro/DESKTOP/configure-system.sh "nonatomic"
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
            "$TOOLS_FOLDER"/modules/post-install/distro/LAPTOP/install-nvidia.sh
            ;;
        2)
            "$TOOLS_FOLDER"/modules/post-install/distro/shared/install-packages.sh "nonatomic"
            ;;

        3)
            "$TOOLS_FOLDER"/modules/post-install/distro/LAPTOP/configure-system.sh "nonatomic"
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
            "$TOOLS_FOLDER"/modules/core/menu.sh
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
            "$TOOLS_FOLDER"/modules/post-install/distro/shared/cleanup-atomic.sh
            "$TOOLS_FOLDER"/modules/post-install/distro/shared/install-packages.sh "atomic"
            ;;

        3)
            "$TOOLS_FOLDER"/modules/post-install/distro/DESKTOP/configure-system.sh "atomic"
            "$TOOLS_FOLDER"/modules/post-install/distro/shared/configure-system.sh "atomic"
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
            "$TOOLS_FOLDER"/modules/post-install/distro/LAPTOP/install-atomic-nvidia.sh
            ;;

        2)
            "$TOOLS_FOLDER"/modules/post-install/distro/shared/cleanup-atomic.sh
            "$TOOLS_FOLDER"/modules/post-install/distro/shared/install-packages.sh "atomic"
            ;;

        3)
            "$TOOLS_FOLDER"/modules/post-install/distro/DESKTOP/configure-system.sh "atomic"
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
            laptop_atomic_menu
            ;;

        esac
        unset input
        laptop_atomic_menu
}

if [ "$1" == "fedora" ]
then
    fedora_menu
elif [ "$1" == "atomic" ]
then
    atomic_menu
else
    echo "error"
fi
