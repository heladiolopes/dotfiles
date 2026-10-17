if [[ -t 0 ]] && command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --zsh)"
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init --cmd cd zsh)"
fi

if command -v pyenv >/dev/null 2>&1; then
  if [[ -w $PYENV_ROOT/shims || ! -e $PYENV_ROOT/shims ]]; then
    eval "$(pyenv init - zsh)"
  else
    eval "$(pyenv init - zsh --no-rehash)"
  fi
fi

if command -v thefuck >/dev/null 2>&1; then
  eval $(thefuck --alias)
fi
