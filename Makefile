.PHONY: stow

stow: ## Execute stow to install packages
	@stow

clean: ~/.vimrc ~/.zshrc ~/.tmux.con
	rm -rf $?
