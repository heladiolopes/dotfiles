# Dotfiles

Personal shell, terminal, editor, and Hyprland configuration, organized as GNU
Stow packages. Profiles select packages; deployment uses Stow directly.

## Layout

```text
packages/  configuration paths relative to your home directory
profiles/  declarative lists of Stow packages
themes/    predefined application themes
assets/    background images
scripts/   deployment, validation, and profile utilities
```

For example, `packages/kitty/.config/kitty/kitty.conf` is installed as a symlink
at `~/.config/kitty/kitty.conf`. Keep the checkout in place after deployment:
configuration links, themes, and backgrounds refer to its contents.

## Dependencies

Deployment requires Linux, Bash 4+, GNU Stow, GNU coreutils, GNU findutils,
grep, and sed. Install the applications for the packages you select separately;
profiles do not install software.

- Shell: Bash, Zsh 5.1+, and optionally Starship, fzf, zoxide, pyenv, and thefuck.
  Zsh loads available plugins from `/usr/share/zsh/plugins/`, including fzf-tab,
  zsh-autosuggestions, zsh-vi-mode, and zsh-syntax-highlighting. Startup does not
  download plugins.
- Terminal and development: Git, bat, btop, Kitty, tmux, Yazi, lazygit, Neovim,
  and Vim. Git uses diff-so-fancy and less; tmux integrations use fzf, gitmux,
  lazygit, and Yazi. Editor plugins may require their own runtime dependencies
  and downloads.
- Desktop: a Hyprland version supporting Lua configuration, Hypridle, Hyprlock,
  Hyprpaper, Kanshi, Waybar, Rofi, SwayOSD, wlogout, and a Nerd Font. Helpers use
  jq, cliphist, wl-clipboard, grim, and slurp. Autostart also expects KDE's
  authentication agent and `kbuildsycoca6`.

## Profiles

| Profile | Packages |
| --- | --- |
| `base` | bash, bin, foundation, shell |
| `desktop` | hypr, idle-inhibitor, kanshi, rofi, swayosd, userdirs, waybar, wlogout |
| `development` | bat, btop, git, kitty, tmux, yazi, zsh, nvim, vim, lazygit |
| `gaming` | empty |
| `laptop` | empty |

Profiles accept a `packages:` key followed by package names, plus comments and
blank lines. Multiple profiles are combined and deduplicated:

```bash
./scripts/resolve-profiles base desktop development
```

For personal Git overrides, create `~/.config/git/local.config`. The tracked Git
configuration contains a personal name and email; review them before use.

## Validate and deploy

Deploy one or more profiles to your home directory:

```bash
./scripts/deploy base development
```

The script resolves and deduplicates the selected packages, validates the target,
and runs Stow with `--no-folding`. It creates the configured user directories
when `userdirs` is selected. It works from any working directory and does not
install software or start services.

Try a temporary target before deploying to your actual home:

```bash
target_home="$(mktemp -d)"
./scripts/deploy --target "$target_home" base desktop development
```

The target must be an existing absolute directory; it defaults to `$HOME`.
Existing regular files and incompatible symlinks block deployment. Review and
move conflicts yourself before retrying. Repeated deployment keeps the same
managed links. Empty profiles are accepted and deploy no packages.

To inspect a target without deploying:

```bash
./scripts/validate --target "$HOME" base development
```

Validation is read-only and reports tab-separated subsystem, status, target,
and detail fields. Exit status `0` means safe to deploy, `1` means conflicts,
and `2` means a usage, configuration, dependency, or inspection error. Missing
links are safe to deploy. Stale managed links are informational and require
manual review.

After deploying `idle-inhibitor` to your real home, run
`systemctl --user daemon-reload` in your user session. This reloads unit files;
it does not enable or start the inhibitor. Open fresh shell sessions after
deploying shell configuration.

You can also manage individual packages with Stow directly from the checkout
root. For example, refresh Kitty's links or remove them:

```bash
stow --restow --no-folding --dir "$PWD/packages" --target "$HOME" kitty
# To remove managed Kitty links instead:
# stow --delete --no-folding --dir "$PWD/packages" --target "$HOME" kitty
```

Unstowing leaves unrelated files and created user directories in place.
Runtime theme and background selections are separate from Stow links.

## Themes and backgrounds

Deep Ocean and Tokyo Night provide coordinated terminal and desktop colors.
Initialize the selections after deployment:

```bash
~/.local/bin/theme-switch --apply
~/.local/bin/background-switch --apply
```

Hyprland restores both selections on startup. Each helper accepts `--list`,
`--current`, `--apply`, and `--help`; pass a theme name or background filename
to select it without interaction. With no arguments, Rofi opens a picker.
Theme state lives under `XDG_STATE_HOME`; background selection uses
`~/.local/share/backgrounds/current`. Background selection is independent of
theme selection. Both helpers refuse to replace conflicting local state.

## Desktop shortcuts

| Shortcut | Action |
| --- | --- |
| `Print` | Screenshot menu |
| `Shift+Print` | Copy active monitor screenshot |
| `Super+Print` | Capture a region |
| `Super+Shift+Print` | Copy a region screenshot |
| `Super+Shift+B` | Background picker |
| `Super+V` | Clipboard history with previews |
| `Super+Shift+/` | Search active keybindings |
| `Super+I` | Toggle idle inhibitor |

Monitor defaults are portable, with optional rules for specific displays in
the Hyprland and Kanshi configuration. Review those rules for your hardware.
