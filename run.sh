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
    echo "(3) Setup Corectrl                (4) Game Profiles"
    echo "(5)"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            "$TOOLS_FOLDER"/conf.sh "grub"
            ;;

        2)
            "$TOOLS_FOLDER"/conf.sh "kde_gdrive_fix"
            ;;

        3)
            "$TOOLS_FOLDER"/conf.sh "corectrl"
            ;;
        
        4)  
            "$TOOLS_FOLDER"/conf.sh "game_profiles"
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

export TOOLS_FOLDER                          # stores full path for dsks-tools
export COPYRIGHT="Copyright (c) 2024 Jordan Bottoms"
export VERSION=""
TOOLS_FOLDER=$(pwd)
main_menu