# Dotfiles Setup

This repository contains instructions and configuration files for replicating the development environment.

- VSCode Extensions and Settings
- JupyterLab Shortcuts
- Aliases and custom commands in the terminal (`.bashrc`)
- Git Settings
- JetBrains Mono Font

### VSCode Settings
- Install the extensions listed in `vscode/extensions.txt`:
  ```bash
  xargs -n1 code --install-extension < vscode/extensions.txt
  ```
  Optionally, install extensions manually via marketplace.

- Copy the settings:
  ```bash
  cp vscode/settings.json ~/.config/Code/User/settings.json
  ```
  Optionally, open the command pallete, search for "Preferences: Open User Settings (JSON)" and copy the contents of `vscode/settings.json`.

### JupyterLab
<!-- TODO: prepare jupyterlab configuration. -->

### Terminal (Bash Aliases & Configurations)
<!-- TODO: prepare terminal configuration. -->

### Git Config
- Copy the Git settings:
  ```bash
  cp git/.gitconfig ~/.gitconfig
  ```
  In the `.gitconfig`, in the `[user]` field, edit the fields with your name and email.

### JetBrains Mono Font
Go to [JetBrains Mono](https://www.jetbrains.com/pt-br/lp/mono/) download and install the font in your system.
