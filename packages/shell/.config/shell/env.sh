# shellcheck shell=bash
# Shared non-interactive environment for Bash and Zsh.
if [ "${WORKSTATION_SHELL_ENV_LOADED:-0}" != 1 ]; then
  WORKSTATION_SHELL_ENV_LOADED=1
  export WORKSTATION_SHELL_ENV_LOADED

  # XDG Base Directories
  export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
  export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
  export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
  export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

  # Set default editor
  if [ -z "${EDITOR:-}" ]; then
    if command -v nvim >/dev/null 2>&1; then
      EDITOR='nvim'
    elif command -v vim >/dev/null 2>&1; then
      EDITOR='vim'
    else
      EDITOR='vi'
    fi
  fi
  export EDITOR
  export VISUAL="${VISUAL:-$EDITOR}"
  export SUDO_EDITOR="${SUDO_EDITOR:-$EDITOR}"

  # Keep tool data out of $HOME when supported
  export CARGO_HOME="${CARGO_HOME:-$XDG_DATA_HOME/cargo}"
  export RUSTUP_HOME="${RUSTUP_HOME:-$XDG_DATA_HOME/rustup}"
  export GOPATH="${GOPATH:-$XDG_DATA_HOME/go}"
  export PYENV_ROOT="${PYENV_ROOT:-$XDG_DATA_HOME/pyenv}"
  export NPM_CONFIG_CACHE="${NPM_CONFIG_CACHE:-$XDG_CACHE_HOME/npm}"
  export PYTHON_HISTORY="${PYTHON_HISTORY:-$XDG_CACHE_HOME/python/history}"
  export OLLAMA_MODELS="${OLLAMA_MODELS:-$XDG_DATA_HOME/ollama/models}"

  workstation_path_prepend() {
    case ":${PATH:-}:" in
      *":$1:"*) ;;
      *) PATH="$1${PATH:+:$PATH}" ;;
    esac
  }

  workstation_path_prepend /usr/local/bin
  [ ! -d "$PYENV_ROOT/bin" ] || workstation_path_prepend "$PYENV_ROOT/bin"
  workstation_path_prepend "$GOPATH/bin"
  workstation_path_prepend "$HOME/.local/bin"
  export PATH
  unset -f workstation_path_prepend
fi
