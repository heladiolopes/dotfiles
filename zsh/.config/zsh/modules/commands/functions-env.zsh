loadenv() {
  emulate -L zsh
  setopt localoptions allexport extendedglob no_nomatch

  local env_file=$1
  local -a env_files

  if [[ -z $env_file ]]; then
    env_files=(.env(N) *.env(N) .env.*(N))
    env_files=(${(u)env_files})

    if (( ${#env_files} == 0 )); then
      print -u2 "loadenv: no .env files found"
      return 1
    fi

    if (( ${#env_files} > 1 )); then
      print -u2 "loadenv: multiple .env files found. Choose one:"
      print -u2 -- "${(F)env_files}"
      return 1
    fi

    env_file=$env_files[1]
  fi

  if [[ ! -f $env_file ]]; then
    print -u2 "loadenv: file not found: $env_file"
    return 1
  fi

  source "$env_file"
  print "loadenv: loaded $env_file"
}

if (( $+functions[compdef] )); then
  _loadenv() {
    local -a env_files

    env_files=(.env(N) *.env(N) .env.*(N))
    env_files=(${(u)env_files})

    _describe '.env file' env_files
  }

  compdef _loadenv loadenv
fi

zstyle ':fzf-tab:complete:loadenv:*' fzf-preview 'bat --style=numbers --color=always $realpath'
