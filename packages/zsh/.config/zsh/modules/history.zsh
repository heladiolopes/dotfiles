HISTSIZE=100000
SAVEHIST=$HISTSIZE
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
mkdir -p -- "${HISTFILE:h}"
HISTORY_IGNORE='(c|cl|ls|cd)([[:space:]]#|)'

setopt append_history
setopt share_history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zshaddhistory() {
  emulate -L zsh
  setopt extended_glob
  [[ $1 != ${~HISTORY_IGNORE} ]]
}
