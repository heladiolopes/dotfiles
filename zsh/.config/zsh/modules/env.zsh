# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Set Neovim as default editor
export EDITOR='vim'
export SUDO_EDITOR="$EDITOR"

# XDG Base Directories
export XDG_CONFIG_HOME="$HOME/.config"       # Configurations
export XDG_CACHE_HOME="$HOME/.cache"         # Non-essential (cached) data
export XDG_DATA_HOME="$HOME/.local/share"    # Data files
export XDG_STATE_HOME="$HOME/.local/state"   # State files

# Clean-up home directory
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/rustup"
export NPM_CONFIG_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/npm"
export PYTHON_HISTORY="${XDG_CACHE_HOME:-$HOME/.cache}/python/history"
export OLLAMA_MODELS="$XDG_DATA_HOME/ollama/models"
