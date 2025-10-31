#!/usr/bin/bash
gpu_picker(){

    # personal note: passing --nvidia isnt actually needed for running steam
    # under distrobox. Possibly only if you are running nvidia-container-toolkit
    # which so far only creates issues with installing libicu resulting in several
    # programs to fail. Megasync and proton apps (iirc) are examples.
    echo "Pick a GPU."
    echo "(1) AMD                                           (2) Nvidia"
    echo "(h) Help                                          (0) Cancel"
    read -r GPU_TYPE
    if [ "$GPU_TYPE" == "1" ]
    then
        distrobox create $GPU_ARG --name $CONTAINER_NAME --image $IMAGE
        #toolbox create $CONTAINER_NAME --distro fedora --release $RELEASE
    elif [ "$GPU_TYPE" == "2" ]
    then
        GPU_ARG="--nvidia"
        distrobox create $GPU_ARG --name $CONTAINER_NAME --image $IMAGE
        #toolbox create $CONTAINER_NAME --distro fedora --release $RELEASE
    elif [ "$GPU_TYPE" == "0" ]
    then
        echo "User canceled"
    else
        echo "Unkown option selected."
        gpu_picker
    fi
}

#GPU_ARG=""
CONTAINER_NAME=$1
IMAGE="fedora:42 "
#RELEASE="42"
distrobox create  --name $CONTAINER_NAME --image $IMAGE