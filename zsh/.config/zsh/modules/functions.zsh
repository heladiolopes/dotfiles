_livegrep() {
  local selected

  selected=$(
    fzf --ansi \
        --height 80% \
        --layout=reverse \
        --disabled \
        --query "$*" \
        --bind "change:reload:rg --line-number --column --no-heading --color=always --smart-case --hidden --glob '!.git' {q} || true" \
        --delimiter : \
        --preview 'bat --style=numbers --color=always --highlight-line {2} {1}' \
        --preview-window 'right:60%:+{2}-/2'
  )

  [[ -z "$selected" ]] && return

  local file line column
  file=$(echo "$selected" | cut -d: -f1)
  line=$(echo "$selected" | cut -d: -f2)
  column=$(echo "$selected" | cut -d: -f3)

  nvim +"call cursor($line, $column)" "$file"
}

_livegrep_widget() {
  zle -I
  _livegrep
}
zle -N _livegrep_widget
bindkey '^G' _livegrep_widget
alias fg=_livegrep_widget

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
