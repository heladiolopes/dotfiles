# File System
alias ls="eza -lh --group-directories-first --icons=auto"
alias ll="ls -a"
alias lt="eza --tree --level=2 --long --icons --git"
alias lta="lt -a"
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
# alias ls="ls --color=auto"
# alias ll="ls -alhF"
# alias la="ls -A"
# alias l="ls -CF"

# Verbosity and settings
alias cp="cp -vi"
alias mv="mv -iv"
alias rm="rm -vI"
alias mkd="mkdir -pv"

# Colorize
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias ip="ip -colo=auto"

# Directories
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Tools
alias vim="n"
alias cat="bat"
alias randint="rand --type int"
alias randstr="rand --type str"
alias randhex="rand --type hex --length 7"
n() { if [ "$#" -eq 0 ]; then nvim .; else nvim "$@"; fi; }

# Cleanup
alias inspect="du -d 1 -h | sort -h"
alias flushpoetry="poetry cache list | awk '{print \$1}' | xargs -I {} poetry cache clear --all {}"
alias flushpip="pip cache purge"
alias flushpyc="find . -type d -name '__pycache__' -exec rm -r {} + && find . -type f -name '*.pyc' -delete"
alias flushgo="go clean -cache"
alias flushprecommit="pre-commit clean"
alias flushuv="uv cache clean"

# Compression
compress() { tar -czf "${1%/}.tar.gz" "${1%/}"; }
alias decompress="tar -xzf"

# Others
alias c="clear"
alias cl="clear"

