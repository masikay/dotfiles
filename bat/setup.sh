#! /usr/bin/env bash

sudo -v

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

if ! confirm_install "bat"; then
    exit 0
fi

info "Setting up bat..."
create_dir ~/.config/bat/themes

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~/.config/bat)"

# bat only loads custom themes from the themes/ subdirectory
find * -name "*.tmTheme" | while read fn; do
    symlink "$SOURCE/$fn" "$DESTINATION/themes/$fn"
done
symlink "$SOURCE/config" "$DESTINATION/config"

# Remove theme symlinks left in the config root by older versions of this script
find "$DESTINATION" -maxdepth 1 -type l -name "*.tmTheme" -delete
clear_broken_symlinks "$DESTINATION"

# Debian/Ubuntu install the binary as batcat
BAT=$(command -v bat || command -v batcat)
if [ -n "$BAT" ]; then
    "$BAT" cache --build
else
    substep_error "bat not found, skipping theme cache build."
fi

success "Successfully set up bat."

