#! /usr/bin/env bash

sudo -v

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

if ! confirm_install "eza themes"; then
    exit 0
fi

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~/.config/eza)"

info "Setting up eza themes..."
create_dir $DESTINATION

find * -name "*.yml" | while read fn; do
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done

clear_broken_symlinks "$DESTINATION"

success "Successfully set up eza themes."

