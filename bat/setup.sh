#! /usr/bin/env bash

sudo -v

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

if ! confirm_install "bat"; then
    exit 0
fi

info "Setting up bat..."
create_dir ~/.config/bat

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~/.config/bat)"

find * -name "*.tmTheme" -o -name "config" | while read fn; do
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done
clear_broken_symlinks "$DESTINATION"

success "Successfully set up bat."

