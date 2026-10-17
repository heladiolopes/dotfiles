if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source_module() {
  [[ ! -r $1 ]] || source "$1"
}

source_module "$ZDOTDIR/modules/history.zsh"
source_module "$ZDOTDIR/modules/options.zsh"
source_module "$ZDOTDIR/modules/completion.zsh"
source_module "$ZDOTDIR/modules/plugins.zsh"
source_module "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliases.sh"
source_module "${XDG_CONFIG_HOME:-$HOME/.config}/shell/functions.sh"
source_module "$ZDOTDIR/modules/tools.zsh"
source_module "$ZDOTDIR/modules/bindings.zsh"
source_module "$ZDOTDIR/modules/prompt.zsh"
source_module "$ZDOTDIR/modules/highlighting.zsh"

unfunction source_module
