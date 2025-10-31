#!/usr/bin/bash

steam_launch_fix(){
    # this fixes a segmentation fault when running steam for first time
    # on fedora/nobara 42. Only needed on fresh installs of steam. Once
    # setup it doesnt need it.
    __GL_CONSTANT_FRAME_RATE_HINT=3 steam
}

steam_launch_fix
