steam_launch_fix(){
    # this fixes a segmentation fault when running steam for first time
    # on fedora/nobara 42. Only needed on fresh installs of steam. Once
    # setup it doesnt need it.
    __GL_CONSTANT_FRAME_RATE_HINT=3 steam
}

DISTRO=$(source /etc/os-release ; echo $ID)
if [ "$1" == "amd_grub" ]
then
    amd_grub
elif [ "$1" == "nvidia_grub" ]
then
    nvidia_grub
elif [ "$1" == "corectrl" ]
then
    corectrl
elif [ "$1" == "game_profiles" ]
then
    game_profiles
elif [ "$1" == "clamav" ]
then
    clamav
elif [ "$1" == "nvidia_fix" ]
then
    nvidia_fix
elif [ "$1" == "setup_zram" ]
then
    setup_zram
elif [ "$1" == "steam_launch" ]
then
    steam_launch_fix
else
    echo "error"
fi
