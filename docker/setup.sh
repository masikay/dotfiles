#! /usr/bin/env bash

sudo -v

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

if ! grep -qi microsoft /proc/version; then
    info "No WSL installation: skip Docker WSL setup"
    exit 0
fi 


info "Setting up docker ..."

substep_info "Adding Docker's official GPG key ..."
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

substep_info "Adding the repository to Apt sources ..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

substep_info "Installing Docker packages ..."
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

substep_info "Adding $USER to docker group ..."
sudo usermod -aG docker $USER

substep_info "Making dockerd passwordless ..."
echo "%docker ALL=(ALL) NOPASSWD:/usr/sbin/dockerd,/usr/bin/dockerd" | sudo tee /etc/sudoers.d/docker > /dev/null

