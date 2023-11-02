#! /usr/bin/env bash

DIR=$(dirname "$0")
cd "$DIR"

. ../../../scripts/functions.sh

COMMENT=\#*

sudo -v

info "Installing Debian/Ubuntu packages ..."
substep_info "Adding official Docker repository ..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update && sudo apt -y upgrade
sudo apt -y install $(cat pkglist)

substep_info "Installing lsd ..."
LSD_VERSION=$(curl -s "https://api.github.com/repos/lsd-rs/lsd/releases/latest" | grep -Po '"tag_name": "\vK[0-9.]+')
curl -Lo lsd.deb "https://github.com/olsd-rs/lsd/releases/latest/download/lsd_${LSD_VERSION}_amd64.deb"
sudo dpkg -i lsd.deb
rm -rf lsd.deb

substep_info "Adding user $(USER) to docker group"
sudo usermod -aG docker $USER

success "Finished installing Debian/Ubuntu packages."

