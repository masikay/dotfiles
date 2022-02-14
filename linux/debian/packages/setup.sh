#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../../../scripts/functions.sh

COMMENT=\#*

sudo -v

info "Installing Debian/Ubuntu packages..."

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository https://cli.github.com/packages
sudo apt update && sudo apt upgrade
sudo apt -y install < pkglist

success "Finished installing Debian/Ubuntu packages."

