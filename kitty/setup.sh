#! /usr/bin/env bash

sudo -v

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

if ! confirm_install "kitty"; then
    exit 0
fi

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~/.config/kitty)"

info "Setting up kitty..."
create_dir $DESTINATION

find * -name "*.conf" | while read fn; do
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done
clear_broken_symlinks "$DESTINATION"

success "Successfully set up kitty."

