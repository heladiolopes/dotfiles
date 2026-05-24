typeset -gU path PATH

path=(
  "$HOME/bin"
  "$HOME/.local/bin"
  "/usr/local/bin"
  $path
)

export PATH

# Set Neovim as default editor
export EDITOR='vim'
export SUDO_EDITOR="$EDITOR"

# XDG Base Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Keep tool data out of $HOME when supported.
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/rustup"
export NPM_CONFIG_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/npm"
export PYTHON_HISTORY="${XDG_CACHE_HOME:-$HOME/.cache}/python/history"
export OLLAMA_MODELS="${XDG_DATA_HOME:-$HOME/.local/share}/ollama/models"
