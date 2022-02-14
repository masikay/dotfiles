#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../../../scripts/functions.sh

COMMENT=\#*

sudo -v

info "Installing Arch/Manjaro packages..."
sudo pacman -Syu --noconfirm
sudo pacman -Sy --noconfirm yay
yay -S --needed --noconfirm - < pkglist
sudo pacman -R vi --noconfirm
sudo ln -sf  /usr/bin/vim /usr/bin/vi
success "Finished installing Arch/Manjaro packages."
