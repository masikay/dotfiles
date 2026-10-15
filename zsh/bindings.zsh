# =========================================================
# Keybindings
# =========================================================

# Ensure Emacs keymap is active
bindkey -e

# Terminfo / Arrow Key fixes
bindkey '^[[H' beginning-of-line       # Home key
bindkey '^[[F' end-of-line             # End key
bindkey '^[[3~' delete-char            # Delete key

# Word navigation for common terminal emulators (Ctrl + Left/Right)
bindkey '^[[1;5D' backward-word        # Ctrl + Left
bindkey '^[[1;5C' forward-word         # Ctrl + Right

# History search (Prefix matching)
bindkey '^P' history-search-backward   # Ctrl + P
bindkey '^N' history-search-forward    # Ctrl + N

# Region manipulation
bindkey '^[w' kill-region              # Alt + W (Cut selection)

# Bind a ZLE widget specifically in Emacs mode
bindkey -M emacs '^F' _fzf_file_no_hidden