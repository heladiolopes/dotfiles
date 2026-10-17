# shellcheck disable=SC1091
shell_config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
[ ! -r "$shell_config_home/shell/env.sh" ] || . "$shell_config_home/shell/env.sh"
unset shell_config_home

case $- in
  *i*) [ ! -r "$HOME/.bashrc" ] || . "$HOME/.bashrc" ;;
esac
