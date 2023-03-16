#! /usr/bin/env bash

DIR=$(dirname "$0")
cd "$DIR"

. ../../../scripts/functions.sh

COMMENT=\#*

sudo -v

info "Installing Fedora/Nobara packages ..."
sudo dnf update -y
sudo dnf upgrade -y
sudo dnf install -y $(cat pkglist)
success "Finished installing Fedora/Nobara packages."

