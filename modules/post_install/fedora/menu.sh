#!/usr/bin/bash

device_menu(){
    echo "              Device menu"
    echo "(1) Desktop                       (2) Laptop"
    echo "(3) MiniPC"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            "$TOOLS_FOLDER"/modules/post_install/fedora/desktop/desktop.sh
            ;;

        2)
            "$TOOLS_FOLDER"/modules/post_install/fedora/laptop/laptop.sh
            ;;

        3)
            "$TOOLS_FOLDER"/modules/post_install/fedora/minipc/minipc.sh
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
device_menu
