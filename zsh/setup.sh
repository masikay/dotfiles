#! /usr/bin/env bash

sudo -v

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~/.config/zsh)"
ZSH_PATH=$(which zsh)

info "Setting up zsh shell..."

substep_info "Creating zsh custom folders..."
mkdir -p "$DESTINATION/custom/plugins"
mkdir -p "$DESTINATION/custom/themes"

symlink $SOURCE/zshenv ~/.zshenv

find * -name "*rc" -o -name "*.zsh" | while read fn; do
    symlink "$SOURCE/$fn" "$DESTINATION/.$fn"
done
clear_broken_symlinks "$DESTINATION"

set_zsh_shell() {
    if grep --quiet zsh <<< "$SHELL"; then
        success "zsh shell is already set up."
    else
        substep_info "Adding zsh executable to /etc/shells"
        if grep --fixed-strings --line-regexp --quiet "$ZSH_PATH" /etc/shells; then
            substep_success "zsh executable already exists in /etc/shells."
        else
            if sudo bash -c "echo $ZSH_PATH >> /etc/shells"; then
                substep_success "zsh executable added to /etc/shells."
            else
                substep_error "Failed adding zsh executable to /etc/shells."
                return 1
            fi
        fi
        substep_info "Changing shell to zsh"
        if sudo chsh -s "$ZSH_PATH" "$USER"; then
            substep_success "Changed shell to zsh"
        else
            substep_error "Failed changing shell to zsh"
            return 2
        fi
    fi
}

if set_zsh_shell; then
    success "Successfully set up zsh shell."
else
    error "Failed setting up zsh shell."
fi

if clone_git_repo https://github.com/ohmyzsh/ohmyzsh.git ~/.config/zsh/.oh-my-zsh; then
    success "Successfully installed Oh My Zsh."
else
    error "Failed installing Oh My Zsh."
fi

if clone_git_repo https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/custom/plugins/zsh-autosuggestions; then
    success "Successfully installed Zsh Autosuggestions."
else
    error "Failed installing Zsh Autosuggestions."
fi

if clone_git_repo https://github.com/zsh-users/zsh-history-substring-search ~/.config/zsh/custom/plugins/zsh-history-substring-search; then
    success "Successfully installed Zsh History Substring Search."
else
    error "Failed installing Zsh History Substring Search."
fi

if clone_git_repo https://github.com/zsh-users/zsh-syntax-highlighting ~/.config/zsh/custom/plugins/zsh-syntax-highlighting; then
    success "Successfully installed Zsh Syntax Highlighting."
else
    error "Failed installing Zsh Syntax Highlighting."
fi

if clone_git_repo https://github.com/romkatv/powerlevel10k.git ~/.config/zsh/custom/themes/powerlevel10k; then
    success "Successfully installed Powerlevel10k."
else
    error "Failed installing Powerlevel10k."
fi