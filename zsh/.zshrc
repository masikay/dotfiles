# =========================================================
# History
# =========================================================

HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

# =========================================================
# Shell behaviour
# =========================================================

setopt AUTOCD
setopt NOBEEP
setopt NUMERIC_GLOB_SORT  # sort file10 after file9, not after file1

# Initialize zoxide
eval "$(zoxide init zsh)"

# =========================================================
# Completion
# =========================================================

# Load completion system
autoload -Uz compinit

# Initialize completion with cached metadata file
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

# Enable interactive completion menu selection
zstyle ':completion:*' menu select

# Make completion case-insensitive
# Example: "doc" can complete to "Documents"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # lowercase input matches upper and lower

# =========================================================
# Fuzzy finder
# =========================================================

FZF_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/fzf"

# Add fzf binary to PATH if it exists locally
if [[ -d "$FZF_DIR/bin" ]] && [[ ":$PATH:" != *":$FZF_DIR/bin:"* ]]; then
  export PATH="$FZF_DIR/bin:$PATH"
fi

# Install latest fzf only if the command is genuinely missing
if ! command -v fzf &>/dev/null; then
  echo "fzf not found. Installing latest release..."
  if [ ! -d "$FZF_DIR" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git "$FZF_DIR"
  fi
  "$FZF_DIR/install" --bin --no-update-rc --no-completion --no-key-bindings
  export PATH="$FZF_DIR/bin:$PATH"
fi

# Arch & Fedora
if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh

# Ubuntu
elif [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  source /usr/share/doc/fzf/examples/completion.zsh

# macOS / Homebrew (Apple Silicon)
elif [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
  source /opt/homebrew/opt/fzf/shell/completion.zsh

# macOS / Homebrew (Intel)
elif [[ -f /usr/local/opt/fzf/shell/key-bindings.zsh ]]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
  source /usr/local/opt/fzf/shell/completion.zsh

# Local Git-cloned fzf
elif [[ -f "$FZF_DIR/shell/key-bindings.zsh" ]]; then
  source "$FZF_DIR/shell/key-bindings.zsh"
  source "$FZF_DIR/shell/completion.zsh"
fi

# =========================================================
# Modular Config Files
# =========================================================

# fzf configuration
[[ ! -f $ZDOTDIR/fzf.zsh ]] || source $ZDOTDIR/fzf.zsh

# Aliases
[[ ! -f $ZDOTDIR/aliases.zsh ]] || source $ZDOTDIR/aliases.zsh

# Custom keybindings
[[ ! -f $ZDOTDIR/bindings.zsh ]] || source $ZDOTDIR/bindings.zsh

# Plugins and plugin manager
[[ ! -f $ZDOTDIR/plugins.zsh ]] || source $ZDOTDIR/plugins.zsh

# Prompt/theme
[[ ! -f $ZDOTDIR/prompt.zsh ]] || source $ZDOTDIR/prompt.zsh

# =========================================================
# User Custom Configurations
# =========================================================

[[ ! -f $ZDOTDIR/local.zsh ]] || source $ZDOTDIR/local.zsh