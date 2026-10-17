#!/usr/bin/env bash

declare -a DOTFILES_PACKAGES=()

dotfiles_load_profile() {
  local profile=$1 file
  local raw line value line_number=0 saw_packages=false
  file="$DOTFILES_ROOT/profiles/$profile.yaml"
  [[ -f $file ]] || dotfiles_error "invalid profile '$profile': file not found: $file" || return 1

  while IFS= read -r raw || [[ -n $raw ]]; do
    ((line_number += 1))
    line=${raw%%#*}
    [[ -z $(dotfiles_trim "$line") ]] && continue
    if [[ $line =~ ^packages:[[:space:]]*$ ]] && [[ $saw_packages == false ]]; then
      saw_packages=true
    elif [[ $line =~ ^[[:space:]]{2}-[[:space:]]+(.+)[[:space:]]*$ ]] && [[ $saw_packages == true ]]; then
      value=$(dotfiles_trim "${BASH_REMATCH[1]}")
      dotfiles_safe_name "$value" || dotfiles_error "$file:$line_number: invalid package name" || return 1
      DOTFILES_PACKAGES+=("$value")
    else
      dotfiles_error "$file:$line_number: unsupported profile syntax" || return 1
    fi
  done < "$file"

  [[ $saw_packages == true ]] || dotfiles_error "$file: missing packages key" || return 1
}

dotfiles_resolve_profiles() {
  local profile
  # Read by command entrypoints and the Bootstrap integration.
  # shellcheck disable=SC2034
  DOTFILES_ERROR=''
  DOTFILES_PACKAGES=()
  (($#)) || dotfiles_error "at least one profile is required" || return 1
  for profile in "$@"; do
    dotfiles_safe_name "$profile" || dotfiles_error "invalid profile name: $profile" || return 1
    dotfiles_load_profile "$profile" || return 1
  done
  mapfile -t DOTFILES_PACKAGES < <(printf '%s\n' "${DOTFILES_PACKAGES[@]}" | sed '/^$/d' | LC_ALL=C sort -u)
}
