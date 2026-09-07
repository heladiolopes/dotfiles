# Dotfiles

Configuration files for various tools managed using [GNU Stow](https://www.gnu.org/software/stow/).

## Components

- **bash/** – `.bashrc`, `.bash_aliases` and prompt script.
- **zsh/** – `.zshrc` with Powerlevel10k configuration.
- **nvim/** – Neovim configuration using lazy.nvim.
- **tmux/** – tmux configuration and theme files.
- **git/** – Git configuration and commit template.
- **btop/** – configuration for the btop system monitor.
- **yazi/** – settings for the Yazi file manager.
- **bin/** – small utilities such as the `rand` generator.
- **theme/** – coordinated palettes used by the desktop theme switcher.

## Configuration

After cloning the repository, stow the desired packages (the `.stowrc` sets `--target=~/`):
```bash
stow -v bash zsh nvim tmux git btop yazi bin theme
```

Use `stow <package>` for individual folders.

## Theme switcher

Stow the applications you use, plus `bin`, `backgrounds`, and `theme`. Apply the
default theme once after installation:

```bash
stow -v bin backgrounds theme hypr kitty waybar rofi swayosd wlogout btop tmux nvim
theme-switch --apply
```

Run `theme-switch` to select a theme with Rofi, or pass a theme directly:

```bash
theme-switch tokyo-night
theme-switch deep-ocean
theme-switch --current
theme-switch --list
```

Under Hyprland, `Super+Shift+T` opens the theme selector. The selection is
restored on login and updates the wallpaper, Hyprland borders, Kitty, Waybar,
Rofi, SwayOSD, wlogout, btop, tmux, Neovim, and the desktop dark/light hint.
Running Kitty, Waybar, SwayOSD, and tmux sessions are reloaded where supported;
restart btop and Neovim to pick up their new palette.

Each directory under `~/.config/theme-switch/themes/` is a complete theme. To
add one, copy an existing directory, adjust its assets and `theme.conf`, then it
will appear automatically in the selector.

Run the switcher's isolated test with `tests/theme-switch.bash`.
