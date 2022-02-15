#! /usr/bin/env bash

DIR=$(dirname "$0")
cd "$DIR"

. ../../../scripts/functions.sh

COMMENT=\#*

sudo -v

info "Installing Debian/Ubuntu packages..."

sudo apt update && sudo apt -y upgrade
sudo apt -y install $(cat pkglist)

success "Finished installing Debian/Ubuntu packages."

