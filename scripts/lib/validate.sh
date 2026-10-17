#!/usr/bin/env bash

dotfiles_validate_package() {
  local package=$1 package_root entry resolved relative
  package_root="$DOTFILES_ROOT/packages/$package"
  [[ -d $package_root ]] || dotfiles_error "invalid package '$package': directory not found: $package_root" || return 1

  if entry=$(find "$package_root" -mindepth 1 ! -type d ! -type f ! -type l -print -quit) && [[ -n $entry ]]; then
    dotfiles_error "unsafe special file in package '$package': ${entry#"$package_root/"}" || return 1
  fi

  while IFS= read -r -d '' entry; do
    relative=${entry#"$package_root/"}
    [[ $relative != *$'\t'* && $relative != *$'\n'* ]] || dotfiles_error "unsafe control character in package '$package' path" || return 1
    if [[ -L $entry ]]; then
      resolved=$(readlink -f -- "$entry") || dotfiles_error "dangling symbolic link in package '$package': $relative" || return 1
      [[ $resolved == "$DOTFILES_ROOT"/* ]] || dotfiles_error "symbolic link escapes Dotfiles root in package '$package': $relative" || return 1
    fi
  done < <(find "$package_root" \( -type f -o -type l \) -print0)
}

dotfiles_validate_repository() {
  local -a profiles=("$@") all_packages=()
  local required required_directory package entry relative previous tmp

  [[ -d $DOTFILES_ROOT/packages ]] || dotfiles_error "packages directory not found: $DOTFILES_ROOT/packages" || return 1
  [[ -d $DOTFILES_ROOT/profiles ]] || dotfiles_error "profiles directory not found: $DOTFILES_ROOT/profiles" || return 1
  for required_directory in themes assets/backgrounds scripts; do
    [[ -d $DOTFILES_ROOT/$required_directory ]] || dotfiles_error "required directory not found: $DOTFILES_ROOT/$required_directory" || return 1
  done
  if [[ -d $DOTFILES_ROOT/packages/userdirs && ! -x $DOTFILES_ROOT/scripts/converge-userdirs ]]; then
    dotfiles_error "userdirs converger is not executable: $DOTFILES_ROOT/scripts/converge-userdirs" || return 1
  fi
  for required in base desktop development gaming laptop; do
    [[ -f $DOTFILES_ROOT/profiles/$required.yaml ]] || dotfiles_error "required profile not found: $required" || return 1
  done
  if entry=$(find "$DOTFILES_ROOT/packages" -mindepth 1 -maxdepth 1 ! -type d -print -quit) && [[ -n $entry ]]; then
    dotfiles_error "packages/ may contain only package directories: ${entry#"$DOTFILES_ROOT/packages/"}" || return 1
  fi

  if ((${#profiles[@]} == 0)); then
    while IFS= read -r entry; do profiles+=("$(basename "$entry" .yaml)"); done < <(find "$DOTFILES_ROOT/profiles" -mindepth 1 -maxdepth 1 -type f -name '*.yaml' | LC_ALL=C sort)
  fi
  dotfiles_resolve_profiles "${profiles[@]}" || return 1

  while IFS= read -r -d '' entry; do
    package=$(basename "$entry")
    dotfiles_safe_name "$package" || dotfiles_error "invalid package directory name: $package" || return 1
    all_packages+=("$package")
    dotfiles_validate_package "$package" || return 1
  done < <(find "$DOTFILES_ROOT/packages" -mindepth 1 -maxdepth 1 -type d -print0)
  for package in "${DOTFILES_PACKAGES[@]}"; do
    [[ -d $DOTFILES_ROOT/packages/$package ]] || dotfiles_error "invalid package '$package': directory not found: $DOTFILES_ROOT/packages/$package" || return 1
  done
  [[ ! -d $DOTFILES_ROOT/packages/userdirs ]] || dotfiles_validate_userdirs_package || return 1

  tmp=$(dotfiles_make_temp_dir) || dotfiles_error "could not create validation workspace" || return 1
  : > "$tmp/destinations"
  for package in "${all_packages[@]}"; do
    while IFS= read -r -d '' entry; do
      relative=${entry#"$DOTFILES_ROOT/packages/$package/"}
      printf '%s\t%s\n' "$relative" "$package" >> "$tmp/destinations"
    done < <(find "$DOTFILES_ROOT/packages/$package" \( -type f -o -type l \) -print0)
  done
  LC_ALL=C sort -o "$tmp/destinations" "$tmp/destinations"
  previous=''
  while IFS=$'\t' read -r relative package; do
    if [[ $relative == "$previous" ]]; then
      rm -rf -- "$tmp"
      dotfiles_error "multiple packages own the same target: $relative" || return 1
    fi
    previous=$relative
  done < "$tmp/destinations"
  rm -rf -- "$tmp"
}

dotfiles_target_ancestor_conflict() {
  local target=$1 relative=$2 current component parent
  current=$target
  parent=${relative%/*}
  [[ $parent != "$relative" ]] || return 1
  local IFS=/
  read -r -a components <<< "$parent"
  for component in "${components[@]}"; do
    current="$current/$component"
    if [[ -e $current || -L $current ]]; then
      [[ -d $current ]] || { printf '%s' "$current"; return 0; }
    fi
  done
  return 1
}

dotfiles_inspect_stale_links() {
  local target=$1 tmp link relative source suffix package source_relative selected claimed
  tmp=$(dotfiles_make_temp_dir) || { dotfiles_error "could not create stale-link inspection workspace"; return 2; }
  if ! find "$target" -path "$DOTFILES_ROOT" -prune -o -xtype l -print0 > "$tmp/candidates" 2> "$tmp/error"; then
    rm -rf -- "$tmp"
    dotfiles_error "could not inspect target for stale links"
    return 2
  fi
  if ! LC_ALL=C sort -z "$tmp/candidates" > "$tmp/sorted"; then
    rm -rf -- "$tmp"
    dotfiles_error "could not sort stale-link candidates"
    return 2
  fi

  while IFS= read -r -d '' link; do
    source=$(readlink -m -- "$link") || continue
    [[ $source == "$DOTFILES_ROOT/packages/"* ]] || continue
    suffix=${source#"$DOTFILES_ROOT/packages/"}
    [[ $suffix == */* ]] || continue
    package=${suffix%%/*}
    source_relative=${suffix#*/}
    dotfiles_safe_name "$package" || continue
    relative=${link#"$target/"}
    [[ $relative == "$source_relative" ]] || continue
    [[ ! -e $source && ! -L $source ]] || continue
    [[ $relative != *$'\t'* && $relative != *$'\n'* ]] || {
      rm -rf -- "$tmp"
      dotfiles_error "unsafe control character in stale target path"
      return 2
    }

    claimed=false
    for selected in "${DOTFILES_PACKAGES[@]}"; do
      if [[ -e $DOTFILES_ROOT/packages/$selected/$relative || -L $DOTFILES_ROOT/packages/$selected/$relative ]]; then
        claimed=true
        break
      fi
    done
    [[ $claimed == false ]] || continue
    printf 'Stale links\tstale\t%s\t%s\n' "$relative" "$package"
  done < "$tmp/sorted"
  rm -rf -- "$tmp"
}

dotfiles_inspect_target() {
  local target=$1 package entry relative destination source_real destination_real obstruction
  local conflicts=0 tmp detail userdirs_status
  [[ $target = /* ]] || dotfiles_error "target must be an absolute path: $target" || return 2
  [[ -d $target ]] || dotfiles_error "target is not a directory: $target" || return 2

  for package in "${DOTFILES_PACKAGES[@]}"; do
    while IFS= read -r -d '' entry; do
      relative=${entry#"$DOTFILES_ROOT/packages/$package/"}
      destination="$target/$relative"
      if obstruction=$(dotfiles_target_ancestor_conflict "$target" "$relative"); then
        printf 'Dotfiles\tconflict\t%s\tancestor is not a directory: %s\n' "$relative" "${obstruction#"$target/"}"
        ((conflicts += 1))
        continue
      fi
      source_real=$(readlink -f -- "$entry") || { dotfiles_error "could not resolve package source: $entry"; return 2; }
      if destination_real=$(readlink -f -- "$destination" 2>/dev/null) && [[ $destination_real == "$source_real" ]]; then
        printf 'Dotfiles\tcorrect\t%s\tpresent\n' "$relative"
      elif [[ -L $destination ]]; then
        printf 'Dotfiles\tconflict\t%s\tincompatible symbolic link\n' "$relative"
        ((conflicts += 1))
      elif [[ -f $destination ]]; then
        printf 'Dotfiles\tconflict\t%s\texisting regular file\n' "$relative"
        ((conflicts += 1))
      elif [[ -d $destination ]]; then
        printf 'Dotfiles\tconflict\t%s\texisting directory\n' "$relative"
        ((conflicts += 1))
      elif [[ -e $destination ]]; then
        printf 'Dotfiles\tconflict\t%s\texisting path\n' "$relative"
        ((conflicts += 1))
      else
        printf 'Dotfiles\tmissing\t%s\tlink required\n' "$relative"
      fi
    done < <(find "$DOTFILES_ROOT/packages/$package" \( -type f -o -type l \) -print0 | LC_ALL=C sort -z)
  done

  dotfiles_inspect_userdirs "$target"
  userdirs_status=$?
  if ((userdirs_status != 0)); then
    case $userdirs_status in
      2) return 2 ;;
      *) ((conflicts += 1)) ;;
    esac
  fi

  dotfiles_inspect_stale_links "$target" || return 2

  ((conflicts == 0)) || return 1
  ((${#DOTFILES_PACKAGES[@]})) || return 0
  command -v stow >/dev/null 2>&1 || dotfiles_error "required command unavailable: stow; install GNU Stow before target validation" || return 2
  tmp=$(dotfiles_make_temp_dir) || dotfiles_error "could not create Stow validation workspace" || return 2
  if ! stow --simulate --stow --no-folding --dir "$DOTFILES_ROOT/packages" --target "$target" "${DOTFILES_PACKAGES[@]}" > /dev/null 2> "$tmp/stow-error"; then
    detail=$(tr '\n\t' '  ' < "$tmp/stow-error")
    [[ -n $detail ]] || detail='GNU Stow simulation failed'
    printf 'Dotfiles\tconflict\tstow\t%s\n' "$detail"
    rm -rf -- "$tmp"
    return 1
  fi
  rm -rf -- "$tmp"
}
