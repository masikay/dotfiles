#! /usr/bin/env bash

sudo -v

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

if ! confirm_install "fzf catppuccin themes"; then
    exit 0
fi

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~/.config/fzf)"

info "Setting up fzf catppuccin themes..."
create_dir $DESTINATION

find * -name "*.sh" -not -wholename "*setup.sh" | while read fn; do
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done
clear_broken_symlinks "$DESTINATION"

success "Successfully set up fzf catppuccin themes."

