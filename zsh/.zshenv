export XDG_CONFIG_HOME="$HOME/.config"

# zsh locations
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export ZSH=$ZDOTDIR/.oh-my-zsh

# Added locations to path variable
export PATH=$PATH:$HOME/.local/bin

# Vagrant config needed inside WSL2
export VAGRANT_DEFAULT_PROVIDER="hyperv"
export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
