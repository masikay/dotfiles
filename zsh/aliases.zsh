# Better vi
alias vi="nvim"
alias vim="nvim"

# Better ls
alias ls='eza --group-directories-first --color=auto --icons -F=auto'

# Detailed listing
alias ll='eza -l --group-directories-first --color=auto --icons -F=auto'

# Detailed listing including hidden files
alias la='eza -la --group-directories-first --color=auto --icons -F=auto'

# Tree view
alias tree='eza --color=auto --icons --tree'

# Reuse ls completions for eza (avoids defining a separate completion function)
compdef eza=ls

# Better cat
alias cat='bat --style header --style snip --style changes --style header'

# =========================================================
# Core utilities
# =========================================================

alias grep='rg --color=auto'
alias diff='diff --color=auto'
alias df='df -h'

# =========================================================
# Navigation
# =========================================================

alias -- -='cd -'  # -- prevents - being parsed as a flag; cd - jumps to previous directory
alias ..='cd ..'
alias ...='cd ../..'

# =========================================================
# Git
# =========================================================

alias glog='PAGER="less -F -X" git log'                              # -F quit if one screen, -X no clear on exit
alias gadog='PAGER="less -F -X" git log --all --decorate --oneline --graph'
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"