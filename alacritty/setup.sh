#! /usr/bin/env bash

sudo -v

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~/.config/alacritty)"

info "Setting up alacritty..."

find * -name "*.toml" -o -name "*.yml" | while read fn; do
    symlink "$SOURCE/$fn" "$DESTINATION/.$fn"
done
clear_broken_symlinks "$DESTINATION"

success "Successfully set up alacritty."

