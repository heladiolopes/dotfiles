# File system
alias ls="eza -lh --group-directories-first --icons=auto"
alias ll="ls -a"
alias lt="eza --tree --level=2 --long --icons --git"
alias lta="lt -a"
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"

# Verbosity and settings
alias cp="cp -vi"
alias mv="mv -iv"
alias rm="rm -vI"
alias mkd="mkdir -pv"

# Colorize
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias ip="ip --color=auto"

# Compression
compress() { tar -czf "${1%/}.tar.gz" "${1%/}"; }
alias decompress="tar -xzf"
