#!/usr/bin/env bash

dotfiles_trim() {
  local value=$1
  value=${value#"${value%%[![:space:]]*}"}
  value=${value%"${value##*[![:space:]]}"}
  printf '%s' "$value"
}

dotfiles_safe_name() {
  [[ $1 =~ ^[A-Za-z0-9][A-Za-z0-9._@+-]*$ ]]
}

dotfiles_error() {
  # Read by command entrypoints and the Bootstrap integration.
  # shellcheck disable=SC2034
  DOTFILES_ERROR=$1
  return 1
}

dotfiles_make_temp_dir() {
  mktemp -d "${TMPDIR:-/tmp}/dotfiles.XXXXXX"
}
