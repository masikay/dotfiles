#! /usr/bin/env bash

sudo -v

DIR=$(dirname "$0")
cd "$DIR"

. ../../scripts/functions.sh

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~/.config/zsh)"
ZSH_PATH=$(which zsh)

info "Setting up zsh extensions..."

substep_info "Creating zsh custom themes and plugins folders..."
mkdir -p "$DESTINATION/custom/plugins"
mkdir -p "$DESTINATION/custom/themes"

clear_broken_symlinks "$DESTINATION"

clone_git_repo() {
    repo_url=$1
    dest_dir=$2
    depth="--depth 1"

    if [ "$3" == "full" ]; then
        depth=""
    fi

    if [ -e $dest_dir ]; then
        success "$repo_url repo is already installed."
    else
        substep_info "Cloning $repo_url"
        if git clone $depth $repo_url $dest_dir; then
            substep_success "$repor_url repo successfully cloned."
        else
            substep_error "Failed cloning $repo_url repo."
            return 3
        fi
    fi
}

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

