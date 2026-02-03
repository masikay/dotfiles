#! /usr/bin/env bash

sudo -v

DIR=$(dirname "$0")
cd "$DIR"

. ../../scripts/functions.sh

if ! confirm_install "KDE plasma color-schemes"; then
    exit 0
fi

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~/.local/share/color-schemes)"

info "Setting up KDE plasma color-schemes..."
create_dir $DESTINATION

find * -name "*.colors" | while read fn; do
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done
clear_broken_symlinks "$DESTINATION"

success "Successfully set up KDE plasma color-schemes."

