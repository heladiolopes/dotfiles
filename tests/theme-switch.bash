#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd -- "${BASH_SOURCE[0]%/*}/.." && pwd)"
test_root="$(mktemp -d /tmp/theme-switch-test.XXXXXX)"
trap 'rm -rf -- "$test_root"' EXIT

export HOME="$test_root"
export XDG_CONFIG_HOME="$test_root/.config"
export XDG_STATE_HOME="$test_root/.local/state"
export THEME_SWITCH_NO_RELOAD=1

mkdir -p "$XDG_CONFIG_HOME/theme-switch" "$XDG_CONFIG_HOME/backgrounds"
ln -s "$repo_root/theme/.config/theme-switch/themes" "$XDG_CONFIG_HOME/theme-switch/themes"
ln -s "$repo_root/backgrounds/.config/backgrounds/minimalist-bridge.jpg" \
    "$XDG_CONFIG_HOME/backgrounds/minimalist-bridge.jpg"
ln -s "$repo_root/backgrounds/.config/backgrounds/minimalist-firewatch.png" \
    "$XDG_CONFIG_HOME/backgrounds/minimalist-firewatch.png"

switcher="$repo_root/bin/.local/bin/theme-switch"
expected_themes=$'deep-ocean\ntokyo-night'
[[ "$($switcher --list)" == "$expected_themes" ]]

"$switcher" deep-ocean >/dev/null
[[ "$(< "$XDG_STATE_HOME/theme-switch/current")" == "deep-ocean" ]]
[[ "$XDG_CONFIG_HOME/kitty/current-theme.conf" -ef \
    "$XDG_CONFIG_HOME/theme-switch/themes/deep-ocean/kitty.conf" ]]
[[ "$XDG_CONFIG_HOME/hypr/current-wallpaper" -ef \
    "$XDG_CONFIG_HOME/backgrounds/minimalist-bridge.jpg" ]]

"$switcher" tokyo-night >/dev/null
[[ "$($switcher --current)" == "tokyo-night" ]]
[[ "$XDG_CONFIG_HOME/waybar/current-theme.css" -ef \
    "$XDG_CONFIG_HOME/theme-switch/themes/tokyo-night/waybar.css" ]]
[[ "$XDG_CONFIG_HOME/hypr/current-wallpaper" -ef \
    "$XDG_CONFIG_HOME/backgrounds/minimalist-firewatch.png" ]]

if "$switcher" does-not-exist >/dev/null 2>&1; then
    printf 'unknown themes must fail\n' >&2
    exit 1
fi

printf 'theme-switch tests passed\n'
