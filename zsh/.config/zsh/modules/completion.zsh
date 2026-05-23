# Redirect zcompdump to custom cache
export ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-${HOST}"

# Load completions
autoload -Uz compinit
compinit -d "$ZSH_COMPDUMP"

# Include hidden files/directories in completion candidates
_comp_options+=(globdots)

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# fzf-tab preview
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -A --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls -A --color=always $realpath'
