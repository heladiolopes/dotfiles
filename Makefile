TARGET = $(HOME)

add-nvim:
	@stow -v -t $(TARGET) nvim

clean-nvim:
	@stow -vD -t $(TARGET) nvim

add-bash:
	@stow -v -t $(TARGET) bash

clean-bash:
	@stow -vD -t $(TARGET) bash

add-zsh:
	@stow -v -t $(TARGET) zsh

clean-zsh:
	@stow -vD -t $(TARGET) zsh

