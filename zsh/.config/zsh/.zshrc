# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load Modules
source $ZDOTDIR/modules/env.zsh
source $ZDOTDIR/modules/history.zsh
source $ZDOTDIR/modules/completion.zsh
source $ZDOTDIR/modules/zinit.zsh
source $ZDOTDIR/modules/prompt.zsh
source $ZDOTDIR/modules/bindings.zsh
source $ZDOTDIR/modules/aliases.zsh
source $ZDOTDIR/modules/tools.zsh
source $ZDOTDIR/modules/options.zsh
source $ZDOTDIR/modules/functions.zsh
