#! /usr/bin/env bash

DIR=$(dirname "$0")
cd "$DIR"

. ../../../scripts/functions.sh

if ! confirm_install "Fedora packages"; then
    exit 0
fi

COMMENT=\#*

sudo -v

info "Installing Fedora packages ..."
sudo dnf update -y
sudo dnf upgrade -y
sudo dnf install -y $(cat pkglist)
success "Finished installing Fedora packages."

