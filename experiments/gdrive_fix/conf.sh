gdrive_fix(){
    CLIENT_ID=""
    CLIENT_SECRET=""
    printf "Insert client id: "
    read -r CLIENT_ID

    printf "Insert client secret: "
    read -r CLIENT_SECRET
    cp gdrive.provider.bak gdrive.provider
    
    python3 "gdrive.py" "$CLIENT_ID" "$CLIENT_SECRET"
    sudo cp gdrive.provider /usr/share/accounts/providers/kde/gdrive.provider
    
}

if [ "$1" == "gdrive_fix" ]
then
    gdrive_fix
else
    echo "error"
fi