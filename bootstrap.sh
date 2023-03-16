#! /usr/bin/env bash

DIR=$(dirname "$0")
cd "$DIR"

. scripts/functions.sh

os_family() {
    OS=$(uname)
    if [ "${OS}" = "Darwin" ]; then
        OS_FAMILY=macos
    elif [ "${OS}" = "Linux" ]; then
        OS_FAMILY=$(grep -E "^ID=" /etc/os-release |  cut -d= -f2 | sed "s/\"//g")
    elif echo ${OS} | grep CYGWIN_NT; then
        OS_FAMILY=cygwin
    elif echo ${OS} | grep MSYS_NT; then
        OS_FAMILY=mingw
    else
        OS_FAMILY=unknown
    fi

    echo ${OS_FAMILY}
}

# Check if running on macOS or Linux (and whcich Linux derivative)
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
SKIP_DOCKER="dummy"

# Package control must be executed first in order for the rest to work
if [ "$OS" == "macos" ]; then
    ./macos/packages/setup.sh
    SKIP="linux"
else
    ./linux/$OS/packages/setup.sh
    SKIP="macos"
fi

if [ "$OS" == "macos" -o "$OS" == "manjaro" -o "$OS" == "ubuntu" -o "$OS" == "nobara" ]; then
    ./packages/setup.sh
fi

if [ "$OS" == "nobara" ]; then
    SKIP_DOCKER="docker"
fi

find * -name "setup.sh" -not -wholename "*packages*" -not -wholename "$SKIP*" -not -wholename "$SKIP_DOCKER*" | while read setup; do
    echo $setup
    ./$setup
done

SOURCE=$(realpath .)
DESTINATION=$(realpath ~)
symlink "$SOURCE" "$DESTINATION/.dotfiles"

success "Finished installing Dotfiles"
