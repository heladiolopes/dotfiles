# fzf
eval "$(fzf --zsh)"

# zoxide
eval "$(zoxide init --cmd cd zsh)"

# pyenv
export PYENV_ROOT="${XDG_DATA_HOME:-$HOME/.local/share}/pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# go
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export PATH="$GOPATH/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin

