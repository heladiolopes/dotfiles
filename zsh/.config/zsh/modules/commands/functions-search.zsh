# Interactive preferences
_livegrep() {
  local selected
  local file
  local line
  local column

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

  [[ -z $selected ]] && return

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
