#! /usr/bin/env bash

sudo -v

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

SOURCE="$(realpath .)"
DESTINATION="$HOME/.config"
STARSHIP_PATH=$(which starship)

info "Setting up starship prompt..."

find * -name "*.toml" | while read fn; do
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
    success "created symlink $DESTINATION/$fn"
done
clear_broken_symlinks "$DESTINATION"

set_starship() {
    if  [[ $STARSHIP_PATH != "" ]]; then
        success "starship is already installed."
    else
        substep_info "Installing starship"
        if curl -sS https://starship.rs/install.sh | sh; then
            substep_success "starship successfully installed in $(which starship)"
        else
            substep_error "Failed installing starship"
            return 1
        fi
    fi
}

if set_starship; then
    success "Successfully set up starship."
else
    error "Failed setting up starship."
fi