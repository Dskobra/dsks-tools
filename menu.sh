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
    echo "(1) Setup Grub                    (2) Fix KDE GDrive"      
    echo "(3) Setup Corectrl"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            "$TOOLS_FOLDER"/grub.sh
            ;;

        2)
            "$TOOLS_FOLDER"/kde_gdrive_fix.sh
            ;;

        3)
            "$TOOLS_FOLDER"/corectrl.sh
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

main_menu
