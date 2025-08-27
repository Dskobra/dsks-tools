#!/usr/bin/bash

get_desktop_type(){
    DESKTOP_TYPE=$(echo $XDG_CURRENT_DESKTOP)
    echo $DESKTOP_TYPE
    if [ "$DESKTOP_TYPE" == "kde " ]
    then
        flatpak remove -y org.kde.skanpage org.kde.okular org.kde.krdc org.kde.kolourpaint org.kde.kmines org.kde.kcalc  \
        org.kde.gwenview org.kde.elisa org.kde.kmahjongg  org.fedoraproject.Platform.tessdata  org.fedoraproject.Platform.Locale   \
        org.fedoraproject.Platform.GL.default org.fedoraproject.KDE6Platform
    elif [ "$DESKTOP_TYPE" == "GNOME" ]
    then
        flatpak remove -y org.gnome.font-viewer org.gnome.clocks org.gnome.baobab org.gnome.Weather org.gnome.TextEditor org.gnome.Snapshot \
        org.gnome.NautilusPreviewer org.gnome.Maps org.gnome.Loupe org.gnome.Logs org.gnome.Extensions org.gnome.Evince org.gnome.Contacts \
        org.gnome.Connections org.gnome.Characters org.gnome.Calendar org.gnome.Calculator org.fedoraproject.MediaWriter \
        org.fedoraproject.Platform.Locale org.fedoraproject.Platform.GL.default org.fedoraproject.Platform
    else
        echo "Uknown error."
    fi
}
get_desktop_type

