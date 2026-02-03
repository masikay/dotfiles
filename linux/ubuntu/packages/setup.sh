#! /usr/bin/env bash

DIR=$(dirname "$0")
cd "$DIR"

. ../../../scripts/functions.sh

if ! confirm_install "Debian/Ubuntu packages"; then
    exit 0
fi

COMMENT=\#*

sudo -v

info "Installing Debian/Ubuntu packages ..."
substep_info "Adding official Docker repository ..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update && sudo apt -y upgrade
sudo apt -y install $(cat pkglist)

success "Finished installing Debian/Ubuntu packages."

