#! /usr/bin/env bash

sudo -v

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~/.config/nvim)"

info "Creating nvim config folder..."
mkdir -p "$DESTINATION"

symlink $SOURCE/zshenv ~/.zshenv

find * ! -name "setup.sh" | while read fn; do
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done
clear_broken_symlinks "$DESTINATION"

success "Successfully installed nvim configuration files."
