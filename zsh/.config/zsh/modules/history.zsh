# History
HISTSIZE=10000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
SAVEHIST=$HISTSIZE
HISTDUP=erase
HISTORY_IGNORE='(c|cl|ls|cd)([[:space:]]#|)'

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zshaddhistory() {
  emulate -L zsh
  setopt extendedglob
  [[ $1 != ${~HISTORY_IGNORE} ]]
}
