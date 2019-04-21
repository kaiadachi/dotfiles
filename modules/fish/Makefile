FISH_DIR = ~/.config/fish
SELF_FISH_DIR = $(MODULE_DIR)/fish

CLEAN_TARGETS += fish-clean
INSTALL_TARGETS += fish-install
UPDATE_TARGETS +=

.PHONY: fish-clean
fish-clean:
	rm -rf $(FISH_DIR)

.PHONY: fish-install
fish-install:
	mkdir -p $(FISH_DIR)
	ln -sf $(SELF_FISH_DIR)/config.fish $(FISH_DIR)/config.fish
	ln -sf $(SELF_FISH_DIR)/fish_greeting.fish $(FISH_DIR)/fish_greeting.fish
	ln -sf $(SELF_FISH_DIR)/peco.fish $(FISH_DIR)/peco.fish
