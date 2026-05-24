export PYENV_ROOT="${XDG_DATA_HOME:-$HOME/.local/share}/pyenv"

if [[ -d $PYENV_ROOT/bin ]]; then
  typeset -gU path PATH
  path=("$PYENV_ROOT/bin" $path)
  export PATH
fi

if command -v pyenv >/dev/null 2>&1; then
  if [[ -w $PYENV_ROOT/shims || ! -e $PYENV_ROOT/shims ]]; then
    eval "$(pyenv init - zsh)"
  else
    eval "$(pyenv init - zsh --no-rehash)"
  fi
fi
