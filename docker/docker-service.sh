#! /usr/bin/env bash

#DOCKER_DISTRO="$WSL_DISTRO_NAME"
DOCKER_DISTRO="Manjaro"
DOCKER_DIR=/mnt/wsl/shared-docker
DOCKER_SOCK="$DOCKER_DIR/docker.sock"
export DOCKER_HOST="unix://$DOCKER_SOCK"
if [ ! -S "$DOCKER_SOCK" ]; then
    mkdir -pm o=,ug=rwx "$DOCKER_DIR"
    chgrp docker "$DOCKER_DIR"
    /mnt/c/Windows/System32/wsl.exe -d $DOCKER_DISTRO sh -c "nohup sudo -b /usr/sbin/dockerd < /dev/null > $DOCKER_DIR/dockerd.log 2>&1"
fi
