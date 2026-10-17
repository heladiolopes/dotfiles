# shellcheck shell=bash
# shellcheck disable=SC1091
# Bash requires a home-level interactive entry point.
[ ! -r "${XDG_CONFIG_HOME:-$HOME/.config}/bash/bashrc" ] ||
  . "${XDG_CONFIG_HOME:-$HOME/.config}/bash/bashrc"
