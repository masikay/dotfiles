#! /usr/bin/env bash

sudo -v

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

if ! confirm_install "Konsole color schemes"; then
    exit 0
fi

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~/.local/share/konsole)"

info "Setting up Konsole coleo schemes..."
create_dir $DESTINATION

find * -name "*.colorscheme" -o -name "*.profile" | while read fn; do
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done
clear_broken_symlinks "$DESTINATION"

success "Successfully set up Konsole color schemes."

