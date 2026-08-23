#! /usr/bin/env bash

DIR=$(dirname "$0")
cd "$DIR"

. scripts/functions.sh

# Check if running on macOS or Linux (and which Linux distro/derivates)
OS=$(os_family)

info "Prompting for sudo password..."
if sudo -v; then
    # Keep-alive: update existing `sudo` time stamp until `setup.sh` has finished
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
    success "Sudo credentials updated."
else
    error "Failed to obtain sudo credentials."
fi

SKIP=""
SKIP_DOCKER="-not -wholename \"docker*\""

# Package control must be executed first in order for the rest to work
if [ "$OS" == "macos" ]; then
    ./macos/packages/setup.sh
    SKIP="linux"
else
    ./linux/$OS/packages/setup.sh
    SKIP="macos"
fi

while IFS= read -r setup; do
    echo "$setup"
    "./$setup"
done < <(find * -name "setup.sh" -not -wholename "*packages*" -not -wholename "$SKIP*")

SOURCE=$(realpath .)
DESTINATION=$(realpath ~)
symlink "$SOURCE" "$DESTINATION/.dotfiles"

success "Finished installing Dotfiles"
