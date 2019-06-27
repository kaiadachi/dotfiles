KARABINER_DIR = ~/.config/karabiner
SELF_KARABINER_DIR = $(MODULE_DIR)/karabiner


CLEAN_TARGETS += karabiner-clean
INITIALIZE_TARGETS += karabiner-init


.PHONY: karabiner-clean
karabiner-clean:
	rm -rf $(KARABINER_DIR)

.PHONY: karabiner-init
karabiner-init: $(KARABINER_DIR)

$(KARABINER_DIR):
	mkdir -p $(KARABINER_DIR)
	mkdir -p $(KARABINER_DIR)/assets/complex_modifications/
	ln -sf $(SELF_KARABINER_DIR)/karabiner.json $(KARABINER_DIR)/karabiner.json
	ln -sf $(SELF_KARABINER_DIR)/assets/complex_modifications/1554335400.json $(KARABINER_DIR)/assets/complex_modifications/1554335400.json
