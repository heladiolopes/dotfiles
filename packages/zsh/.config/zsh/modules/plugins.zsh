# fzf-tab must follow compinit and precede plugins that wrap completion widgets.
[[ ! -r /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.plugin.zsh ]] || \
  source /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.plugin.zsh
[[ ! -r /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] || \
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
if [[ -r /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh ]]; then
  # Initialize now so tools.zsh and bindings.zsh can set their keys afterward.
  ZVM_INIT_MODE=sourcing
  source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
fi
