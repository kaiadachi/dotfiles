FISH_DIR = ~/.config/fish
SELF_FISH_DIR = $(MODULE_DIR)/fish

CLEAN_TARGETS += fish-clean
INITIALIZE_TARGETS += fish-init

.PHONY: fish-clean
fish-clean:
	rm -rf $(FISH_DIR)

.PHONY: fish-init
fish-init: $(FISH_DIR)

$(FISH_DIR):
	sudo sh -c "echo '/usr/local/bin/fish' >> /etc/shells"
	chsh -s /usr/local/bin/fish
	mkdir -p $(FISH_DIR)
	ln -sf $(SELF_FISH_DIR)/config.fish $(FISH_DIR)/config.fish
	ln -sf $(SELF_FISH_DIR)/peco.fish $(FISH_DIR)/peco.fish
	ln -sf $(SELF_FISH_DIR)/gopath.fish $(FISH_DIR)/gopath.fish
	ln -sf $(SELF_FISH_DIR)/command.fish $(FISH_DIR)/command.fish
