#!/usr/bin/bash
experiments_menu(){
    echo "------------------------"   
    echo "|   Experiments Menu   |"
    echo "------------------------" 
    echo ""
    echo ""
    echo "(1) Gdrive fix"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)
            ./conf.sh "gdrive_fix"
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            experiments_menu
            ;;

        esac
        unset input
        experiments_menu
}
experiments_menu