# shellcheck shell=bash
# shellcheck disable=SC1091
# Bash requires a home-level login entry point.
[ ! -r "${XDG_CONFIG_HOME:-$HOME/.config}/bash/profile.bash" ] ||
  . "${XDG_CONFIG_HOME:-$HOME/.config}/bash/profile.bash"
