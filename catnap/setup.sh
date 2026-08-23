#! /usr/bin/env bash

sudo -v

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

if ! confirm_install "catnap"; then
    exit 0
fi

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~/.config/catnap)"

info "Setting up catnap..."

curl -Lo install.sh https://raw.githubusercontent.com/iinsertNameHere/catnap/main/install.sh
echo "y" | sudo bash install.sh
rm install.sh

rm -f $DESTINATION/config.cat
chown -R $USER $DESTINATION/*

find * -name "*.cat" | while read fn; do
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done

success "Successfully set up catnap."

