#!/usr/bin/bash
gpu_picker(){
    echo "Pick a GPU."
    echo "(1) AMD                                           (2) Nvidia"
    echo "(h) Help                                          (0) Cancel"
    read -r GPU_TYPE
    if [ "$GPU_TYPE" == "1" ]
    then
        distrobox create $GPU_ARG --name $CONTAINER_NAME --image $IMAGE
    elif [ "$GPU_TYPE" == "2" ]
    then
        GPU_ARG="--nvidia"
        distrobox create $GPU_ARG --name $CONTAINER_NAME --image $IMAGE
    elif [ "$GPU_TYPE" == "0" ]
    then
        echo "User canceled"
    else
        echo "Unkown option selected."
        gpu_picker
    fi
}

GPU_ARG=""
CONTAINER_NAME=$1
IMAGE="fedora:42 "
gpu_picker