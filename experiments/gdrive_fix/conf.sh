gdrive_fix(){
    CLIENT_ID=""
    CLIENT_SECRET=""
    printf "Insert client id: "
    read -r CLIENT_ID

    printf "Insert client secret: "
    read -r CLIENT_SECRET
    cp google.provider.bak google.provider
    
    python3 "gdrive.py" "$CLIENT_ID" "$CLIENT_SECRET"
    sudo cp google.provider /usr/share/accounts/providers/kde/google.provider
    
}

if [ "$1" == "gdrive_fix" ]
then
    gdrive_fix
else
    echo "error"
fi