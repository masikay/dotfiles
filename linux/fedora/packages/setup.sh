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

substep_info "starship is not packaged for Fedora, installing via the official install script..."
if curl -sS https://starship.rs/install.sh | sh -s -- --yes; then
    substep_success "starship successfully installed."
else
    substep_error "Failed installing starship."
fi

