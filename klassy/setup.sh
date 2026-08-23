#! /usr/bin/env bash

sudo -v

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

if ! confirm_install "klassy"; then
    exit 0
fi

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~/.config/klassy)"

info "Setting up klassy..."
# Check Linux distro/derivates)
OS=$(os_family)

if [ "$OS" == "arch" ]; then
    substep_info "arch based distro: ensure build depedencies are installed..."
    sudo pacman -S git frameworkintegration gcc-libs glibc kcmutils kcolorscheme kconfig kcoreaddons kdecoration kguiaddons ki18n kiconthemes kwidgetsaddons kwindowsystem qt6-base qt6-declarative qt6-svg xdg-utils extra-cmake-modules kcmutils5 frameworkintegration5 kconfigwidgets5 kiconthemes5 kwindowsystem5 --noconfirm
    substep_success "arch depedencies have been installed"
elif [ "$OS" == "fedora" ]; then
    substep_info "fedora based distro: ensure depedencies are installed..."
    sudo dnf install git cmake extra-cmake-modules gettext
    sudo dnf install "cmake(KF5Config)" "cmake(KF5CoreAddons)" "cmake(KF5FrameworkIntegration)"  "cmake(KF5GuiAddons)" "cmake(KF5WindowSystem)" "cmake(KF5I18n)" "cmake(Qt5DBus)" "cmake(Qt5Quick)" "cmake(Qt5Widgets)" "cmake(Qt5X11Extras)" "cmake(KDecoration3)" "cmake(KF6ColorScheme)" "cmake(KF6Config)" "cmake(KF6CoreAddons)" "cmake(KF6FrameworkIntegration)" "cmake(KF6GuiAddons)" "cmake(KF6I18n)" "cmake(KF6KCMUtils)" "cmake(KF6WindowSystem)" "cmake(Qt6Core)" "cmake(Qt6DBus)" "cmake(Qt6Quick)" "cmake(Qt6Svg)" "cmake(Qt6Widgets)" "cmake(Qt6Xml)"
    substep_success "fedora depedencies have been installed"
fi

substep_info "Download, build and install..."
git clone https://github.com/paulmcauley/klassy
cd klassy
git checkout plasma6.6
./install.sh
cd ..
rm -fr klassy
substep_success "klassy successfully installed"

create_dir $DESTINATION

find * -name "*rc" | while read fn; do
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done
clear_broken_symlinks "$DESTINATION"

success "Successfully set up klassy."

