#!/usr/bin/env bash

declare -a DOTFILES_USERDIR_NAMES=(
  DESKTOP DOWNLOAD TEMPLATES PUBLICSHARE DOCUMENTS MUSIC PICTURES VIDEOS PROJECTS
)
declare -a DOTFILES_USERDIR_RELATIVES=()

dotfiles_package_selected() {
  local expected=$1 package
  for package in "${DOTFILES_PACKAGES[@]}"; do
    [[ $package == "$expected" ]] && return 0
  done
  return 1
}

dotfiles_load_userdirs() {
  local file=$1 raw line key relative component expected
  local -A found=()
  DOTFILES_USERDIR_RELATIVES=()

  [[ -f $file ]] || dotfiles_error "userdirs configuration not found: $file" || return 1
  while IFS= read -r raw || [[ -n $raw ]]; do
    line=${raw%%#*}
    line=$(dotfiles_trim "$line")
    [[ -z $line ]] && continue
    if [[ ! $line =~ ^XDG_([A-Z]+)_DIR=\"\$HOME/([^\"]+)\"$ ]]; then
      dotfiles_error "unsupported userdirs configuration: $line" || return 1
    fi
    key=${BASH_REMATCH[1]}
    relative=${BASH_REMATCH[2]}
    case " ${DOTFILES_USERDIR_NAMES[*]} " in
      *" $key "*) ;;
      *) dotfiles_error "unsupported userdirs key: XDG_${key}_DIR" || return 1 ;;
    esac
    [[ -z ${found[$key]+x} ]] || dotfiles_error "duplicate userdirs key: XDG_${key}_DIR" || return 1
    [[ $relative =~ ^[A-Za-z0-9._/-]+$ && $relative != /* && $relative != */ && $relative != *//* ]] ||
      dotfiles_error "unsafe userdirs path for XDG_${key}_DIR: $relative" || return 1
    IFS=/ read -r -a components <<<"$relative"
    for component in "${components[@]}"; do
      [[ $component != . && $component != .. ]] ||
        dotfiles_error "unsafe userdirs path for XDG_${key}_DIR: $relative" || return 1
    done
    found[$key]=$relative
  done <"$file"

  for expected in "${DOTFILES_USERDIR_NAMES[@]}"; do
    [[ -n ${found[$expected]+x} ]] || dotfiles_error "missing userdirs key: XDG_${expected}_DIR" || return 1
    DOTFILES_USERDIR_RELATIVES+=("${found[$expected]}")
  done
}

dotfiles_validate_userdirs_package() {
  local root="$DOTFILES_ROOT/packages/userdirs/.config"
  local locale
  dotfiles_load_userdirs "$root/user-dirs.dirs" || return 1
  [[ -f $root/user-dirs.locale ]] || dotfiles_error "userdirs locale not found: $root/user-dirs.locale" || return 1
  locale=$(<"$root/user-dirs.locale")
  [[ $locale =~ ^[A-Za-z_]+([.][A-Za-z0-9_-]+)?$ ]] ||
    dotfiles_error "invalid userdirs locale: $root/user-dirs.locale" || return 1
}

dotfiles_userdir_symlink_ancestor() {
  local target=$1 relative=$2 component
  local current=$target parent=${relative%/*}
  [[ $parent != "$relative" ]] || return 1
  local -a components=()
  IFS=/ read -r -a components <<<"$parent"
  for component in "${components[@]}"; do
    current="$current/$component"
    [[ ! -L $current ]] || {
      printf '%s' "$current"
      return 0
    }
  done
  return 1
}

dotfiles_inspect_userdirs() {
  local target=$1 relative destination obstruction conflicts=0
  dotfiles_package_selected userdirs || return 0
  dotfiles_load_userdirs "$DOTFILES_ROOT/packages/userdirs/.config/user-dirs.dirs" || return 2

  for relative in "${DOTFILES_USERDIR_RELATIVES[@]}"; do
    destination="$target/$relative"
    if obstruction=$(dotfiles_target_ancestor_conflict "$target" "$relative"); then
      printf 'User directories\tconflict\t%s\tancestor is not a directory: %s\n' \
        "$relative" "${obstruction#"$target/"}"
      ((conflicts += 1))
    elif obstruction=$(dotfiles_userdir_symlink_ancestor "$target" "$relative"); then
      printf 'User directories\tconflict\t%s\tsymbolic-link ancestor is not safe for creation: %s\n' \
        "$relative" "${obstruction#"$target/"}"
      ((conflicts += 1))
    elif [[ -d $destination ]]; then
      printf 'User directories\tcorrect\t%s\tpresent\n' "$relative"
    elif [[ -L $destination ]]; then
      printf 'User directories\tconflict\t%s\tdangling symbolic link\n' "$relative"
      ((conflicts += 1))
    elif [[ -e $destination ]]; then
      printf 'User directories\tconflict\t%s\texisting path is not a directory\n' "$relative"
      ((conflicts += 1))
    else
      printf 'User directories\tmissing\t%s\tdirectory required\n' "$relative"
    fi
  done
  ((conflicts == 0))
}
