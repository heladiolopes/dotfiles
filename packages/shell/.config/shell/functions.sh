# shellcheck shell=bash
n() {
  if [ "$#" -eq 0 ]; then
    nvim .
  else
    nvim "$@"
  fi
}

y() {
  local tmp cwd
  tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd" || builtin true
  command rm -f -- "$tmp"
}

compress() {
  [ "$#" -eq 1 ] || {
    printf 'usage: compress PATH\n' >&2
    return 2
  }
  tar -czf "${1%/}.tar.gz" "${1%/}"
}

decompress() {
  [ "$#" -eq 1 ] || {
    printf 'usage: decompress ARCHIVE\n' >&2
    return 2
  }
  tar -xzf "$1"
}

# todo: rollback function similar to previous version
loadenv() {
  local env_file="${1:-.env}" status was_allexport=false
  [ "$#" -le 1 ] || {
    printf 'usage: loadenv [FILE]\n' >&2
    return 2
  }
  [ -f "$env_file" ] || {
    printf 'loadenv: file not found: %s\n' "$env_file" >&2
    return 1
  }
  case $env_file in */*) ;; *) env_file="./$env_file" ;; esac
  case $- in *a*) was_allexport=true ;; esac
  set -a
  # shellcheck disable=SC1090
  . "$env_file"
  status=$?
  [[ $was_allexport == true ]] || set +a
  [ "$status" -ne 0 ] || printf 'loadenv: loaded %s\n' "$env_file"
  return "$status"
}

# todo: implement unloadenv

livegrep() {
  command -v rg >/dev/null 2>&1 || {
    printf 'livegrep: rg is required\n' >&2
    return 1
  }
  command -v fzf >/dev/null 2>&1 || {
    printf 'livegrep: fzf is required\n' >&2
    return 1
  }
  command -v bat >/dev/null 2>&1 || {
    printf 'livegrep: bat is required\n' >&2
    return 1
  }
  command -v nvim >/dev/null 2>&1 || {
    printf 'livegrep: nvim is required\n' >&2
    return 1
  }

  local selected file line column
  selected=$(fzf --ansi --height 80% --layout=reverse --disabled --query "$*" \
    --bind "change:reload:rg --line-number --column --no-heading --color=always --smart-case --hidden --glob '!.git' {q} || true" \
    --delimiter : \
    --preview 'bat --style=numbers --color=always --highlight-line {2} {1}' \
    --preview-window 'right:60%:+{2}-/2') || return 0
  [ -n "$selected" ] || return 0

  file=${selected%%:*}
  selected=${selected#*:}
  line=${selected%%:*}
  selected=${selected#*:}
  column=${selected%%:*}
  nvim "+call cursor($line, $column)" "$file"
}

alias fg='livegrep'
