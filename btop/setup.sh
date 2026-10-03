#! /usr/bin/env bash

sudo -v

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

if ! confirm_install "btop"; then
    exit 0
fi

info "Setting up btop..."
create_dir ~/.config/btop/themes

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~/.config/btop/themes)"

find * -name "*.theme" | while read fn; do
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done
clear_broken_symlinks "$DESTINATION"

success "Successfully set up alacritty."

