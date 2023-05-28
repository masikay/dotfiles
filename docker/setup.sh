#! /usr/bin/env bash

sudo -v

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

if ! grep -qi microsoft /proc/version; then
    info "No WSL installation: skip docker WSL setup"
    exit 0
fi 

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~/.local/bin)"

info "Setting up docker ..."

substep_info "Sharing docker between WSL distros: choose a common ID (36257) for the docker group ..."
sudo groupmod -g 36257 docker

substep_info "Adding $USER to docker group ..."
sudo usermod -aG docker $USER

substep_info "Configuring dockerd ..."
DOCKER_DIR=/mnt/wsl/shared-docker
mkdir -pm o=,ug=rwx "$DOCKER_DIR"
chgrp docker "$DOCKER_DIR"

substep_info "Creating dockerd config file ..."
sudo mkdir -p /etc/docker
echo $'{\n  "hosts": ["unix:///mnt/wsl/shared-docker/docker.sock"]\n}' | sudo tee /etc/docker/daemon.json > /dev/null

substep_info "Making dockerd passwordless ..."
echo "%docker ALL=(ALL) NOPASSWD:/usr/sbin/dockerd,/usr/bin/dockerd" | sudo tee /etc/sudoers.d/docker > /dev/null


if [ ! -d "$DESTINATION" ]; then
    substep_info "Creating directory $DESTINATION ..."
    mkdir -p "$DESTINATION"
fi

find * -name "*.sh" -not -wholename "*setup.sh" | while read fn; do
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done
clear_broken_symlinks "$DESTINATION"
