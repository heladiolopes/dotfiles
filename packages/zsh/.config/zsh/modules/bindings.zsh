(( ! $+widgets[autosuggest-accept] )) || bindkey '^y' autosuggest-accept
bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward
bindkey '^[w' kill-region

_livegrep_widget() {
  zle -I
  livegrep
}
zle -N _livegrep_widget
bindkey '^G' _livegrep_widget
