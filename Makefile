.PHONY: help stow

help: ## Show this help message
	@cat $(MAKEFILE_LIST) | \
	awk '$$0 ~ /^\t/ {next;} $$0 ~ /#{2}/ { split($$0, a, "##"); print $$1" "a[2] }'

stow: ## Execute stow to install packages
	@stow

clean: ~/.vimrc ~/.zshrc ~/.tmux.conf ## Remove all links
	rm -rf $?

docs: ## Generate Documentations
