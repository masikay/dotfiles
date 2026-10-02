#! /usr/bin/env bash

DIR=$(dirname "$0")
cd "$DIR"

. ../../../scripts/functions.sh

if ! confirm_install "Ubuntu packages"; then
    exit 0
fi

COMMENT=\#*

sudo -v

info "Installing Ubuntu packages ..."
sudo apt update && sudo apt -y upgrade
sudo apt -y install $(cat pkglist)

success "Finished installing Ubuntu packages."
