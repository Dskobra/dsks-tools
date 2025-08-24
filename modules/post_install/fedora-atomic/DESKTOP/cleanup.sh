#!/usr/bin/bash

get_desktop_type(){
    DESKTOP_TYPE=$(echo $XDG_CURRENT_DESKTOP)
    echo $DESKTOP_TYPE
    if [ "$DESKTOP_TYPE" == "kde " ]
    then
        flatpak remove -y org.kde.skanpage org.kde.okular org.kde.krdc org.kde.kolourpaint org.kde.kmines org.kde.kcalc  \
        org.kde.gwenview org.kde.elisa org.kde.kmahjongg  org.fedoraproject.Platform.tessdata  org.fedoraproject.Platform.Locale   \
        org.fedoraproject.Platform.GL.default org.fedoraproject.KDE6Platform
    elif [ "$DESKTOP_TYPE" == "gnome " ]
    then
        echo "unfinished"
    else
        echo "Uknown error."
    fi
}
get_desktop_type
