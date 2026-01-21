#!/usr/bin/bash
CONTAINER_NAME=$1
IMAGE="fedora:43 "
distrobox create  --name $CONTAINER_NAME --image $IMAGE