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
    echo "(1) Setup Grub                     (2) Setup Corectrl"
    echo "(3) Game Profiles                  (4) Setup zram"
    echo "(5) Various fixes                  (6) Setup clamd"
    echo "(7) Remove rpmfusion               (8) Devices"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            grub_menu
            ;;

        2)
            "$TOOLS_FOLDER"/modules/fixes/corectrl.sh
            ;;
        
        3)  
            "$TOOLS_FOLDER"/modules/fixes/game_profiles.sh
            ;;

        4)
            "$TOOLS_FOLDER"/modules/fixes/zram.sh
            ;;

        5)
            fixes_menu
            ;;

        6)
            "$TOOLS_FOLDER"/modules/fixes/clamd.sh
            ;;

        7)
            "$TOOLS_FOLDER"/modules/fixes/rpmfusion.sh
            ;;

        8)
            post_menu
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

grub_menu(){
    echo "(1) AMD                           (2) NVIDIA"    
    echo "(m) Main Menu                     (0) Exit"    
    printf "Option: "
    read -r input

    case $input in


        1)
            "$TOOLS_FOLDER"/modules/fixes/grub.sh "amd_grub"
            ;;

        2)
            "$TOOLS_FOLDER"/modules/fixes/grub.sh "nvidia_grub"
            ;;

        m)
            main_menu
            ;;

        M)
            main_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            grub_menu
            ;;

        esac
        unset input
}

post_menu(){
    echo "              Device menu"
    echo "(1) Desktop                       (2) Laptop"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            "$TOOLS_FOLDER"/modules/post_install/desktop.sh
            ;;

        2)
            echo "Not finished"
            ;;

        m)
            main_menu
            ;;

        M)
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
}

fixes_menu(){
    echo "------------------"
    echo "|   DSK's Tools  |"
    echo "------------------"
    echo ""
    echo "$COPYRIGHT"
    echo "Released under the MIT license"
    echo ""
    echo ""
    echo "(1) Nvidia gsk fix                 (2) Steam launch fix"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            "$TOOLS_FOLDER"/modules/fixes/nvidia.sh
            ;;

        2)
            "$TOOLS_FOLDER"/modules/fixes/steam.sh
            ;;

        9)
            post_menu
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
main_menu
