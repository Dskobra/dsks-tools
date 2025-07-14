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
    echo "(1) Devices                        (2) Various fixes"
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
    echo "              Pick OS"
    echo "(1) Desktop                       (2) Laptop"
    echo "(3) MiniPC"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            "$TOOLS_FOLDER"/modules/post_install/desktop/desktop.sh
            ;;

        2)
            "$TOOLS_FOLDER"/modules/post_install/laptop/laptop.sh
            ;;

        3)
            "$TOOLS_FOLDER"/modules/post_install/minipc/minipc.sh
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
            post_menu
            ;;

        esac
        unset input
}

device_menu(){
    echo "              Device menu"
    echo "(1) Desktop                       (2) Laptop"
    echo "(3) MiniPC"
    echo "(m) Main Menu                     (0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            "$TOOLS_FOLDER"/modules/post_install/desktop/desktop.sh
            ;;

        2)
            "$TOOLS_FOLDER"/modules/post_install/laptop/laptop.sh
            ;;

        3)
            "$TOOLS_FOLDER"/modules/post_install/minipc/minipc.sh
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
