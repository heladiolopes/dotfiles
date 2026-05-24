export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"

typeset -gU path PATH
path=(
  "$GOPATH/bin"
  "/usr/local/go/bin"
  $path
)

export PATH
