# Zsh requires this home-level entry point to relocate the remaining files.
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

shared_environment="${XDG_CONFIG_HOME:-$HOME/.config}/shell/env.sh"
[[ ! -r "$shared_environment" ]] || source "$shared_environment"
unset shared_environment
