ATOM_DIR = ~/.atom
SELF_ATOM_DIR = $(MODULE_DIR)/atom

CLEAN_TARGETS += atom-clean
INITIALIZE_TARGETS += atom-init

.PHONY: atom-clean
atom-clean:
	rm -rf $(ATOM_DIR)

.PHONY: atom-init
atom-init: $(ATOM_DIR)

$(ATOM_DIR):
	mkdir -p $(ATOM_DIR)
	ln -sf $(SELF_ATOM_DIR)/config.cson $(ATOM_DIR)/config.cson
	ln -sf $(SELF_ATOM_DIR)/init.coffee $(ATOM_DIR)/init.coffee
	ln -sf $(SELF_ATOM_DIR)/keymap.cson $(ATOM_DIR)/keymap.cson
	ln -sf $(SELF_ATOM_DIR)/snippets.cson $(ATOM_DIR)/snippets.cson
	ln -sf $(SELF_ATOM_DIR)/styles.less $(ATOM_DIR)/styles.less

	apm install --packages-file $(PACKAGE_DIR)/atom/packages.txt
