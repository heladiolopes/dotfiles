# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source_module() {
  local file_path=$1

  [[ -r $file_path ]] && source "$file_path"
}

# Core shell state
source_module "$ZDOTDIR/modules/core/env.zsh"
source_module "$ZDOTDIR/modules/core/history.zsh"
source_module "$ZDOTDIR/modules/core/options.zsh"
source_module "$ZDOTDIR/modules/core/completion.zsh"
source_module "$ZDOTDIR/modules/core/bindings.zsh"

# Plugins and external tools
source_module "$ZDOTDIR/modules/plugins/zinit.zsh"
source_module "$ZDOTDIR/modules/tools/fzf.zsh"
source_module "$ZDOTDIR/modules/tools/zoxide.zsh"
source_module "$ZDOTDIR/modules/tools/pyenv.zsh"
source_module "$ZDOTDIR/modules/tools/go.zsh"
source_module "$ZDOTDIR/modules/tools/prompt.zsh"

# Commands and helper functions
source_module "$ZDOTDIR/modules/commands/aliases-filesystem.zsh"
source_module "$ZDOTDIR/modules/commands/aliases-navigation.zsh"
source_module "$ZDOTDIR/modules/commands/aliases-tools.zsh"
source_module "$ZDOTDIR/modules/commands/aliases-maintenance.zsh"
source_module "$ZDOTDIR/modules/commands/functions-editor.zsh"
source_module "$ZDOTDIR/modules/commands/functions-search.zsh"
source_module "$ZDOTDIR/modules/commands/functions-env.zsh"
