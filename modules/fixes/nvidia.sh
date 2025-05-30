#!/usr/bin/bash

nvidia_fix(){
    # this fixes an issue with wayland/x11 where an application fails to launch
    # with a protocol dispatching to wayland error
    mkdir /home/$USER/.config/environment.d
    echo "GSK_RENDERER=gl" > /home/$USER/.config/environment.d/gsk.conf
}

nvidia_fix
