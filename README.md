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

## Configuration

After cloning the repository, stow the desired packages (the `.stowrc` sets `--target=~/`):
```bash
stow -v bash zsh nvim tmux git btop yazi bin
```

Use `stow <package>` for individual folders.

