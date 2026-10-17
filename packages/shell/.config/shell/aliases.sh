# shellcheck shell=bash
# Navigation.
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias c='clear'
alias cl='clear'

# File inspection and guarded mutations.
if command -v eza >/dev/null 2>&1; then
  alias ls='eza -lh --group-directories-first --icons=auto'
  alias ll='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
else
  alias ls='ls --color=auto'
  alias ll='ls -alhF'
fi

# Verbosity and settings
alias cp='cp -vi'
alias mv='mv -iv'
alias rm='rm -vI'
alias mkd='mkdir -pv'

# Colorize
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'

# Tool shortcuts.
alias vim='n'
alias inspect="du -d 1 -h | sort -h"
alias flushpip='pip cache purge'
alias flushpyc="find . -type d -name '__pycache__' -exec rm -r {} + && find . -type f -name '*.pyc' -delete"
alias flushgo='go clean -cache'
alias flushprecommit='pre-commit clean'
alias flushuv='uv cache clean'
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'

# todo: ramdom shortcuts
# alias randint="rand --type int"
# alias randstr="rand --type str"
# alias randhex="rand --type hex --length 7"

if command -v fzf >/dev/null 2>&1 && command -v bat >/dev/null 2>&1; then
  alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
fi

flushpoetry() {
  poetry cache list | awk '{print $1}' | xargs -r -I {} poetry cache clear --all {}
}
