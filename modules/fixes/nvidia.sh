#!/usr/bin/bash

nvidia_fix(){
    # this fixes an issue with wayland/x11 where an application fails to launch
    # with a protocol dispatching to wayland error
    mkdir "$HOME"/.config/environment.d
    echo "GSK_RENDERER=gl" > "$HOME"/.config/environment.d/gsk.conf
}

nvidia_fix
