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
    echo "(3) Game Profiles                  (4) Various fixes"
    echo "(5) Remove rpmfusion"
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
            fixes_menu
            ;;

        5)
            "$TOOLS_FOLDER"/modules/fixes/rpmfusion.sh
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

        m | M )
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

fixes_menu(){
    echo "(1) Nvidia gsk fix                (2) Steam launch fix"
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

        9)
            post_menu
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
main_menu
