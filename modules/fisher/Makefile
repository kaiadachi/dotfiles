FISHER_DIR = ~/.config/fisher
SELF_FISHER_DIR = $(MODULE_DIR)/fisher
FISHER_PLUGINS = $(SELF_FISHER_DIR)/Fisherfile

CLEAN_TARGETS += fisher-clean
INITIALIZE_TARGETS += fisher-init
UPDATE_TARGETS += fisher-update

.PHONY: fisher-clean
fisher-clean:
	rm -rf $(FISHER_DIR)

.PHONY: fisher-init
fisher-init: $(FISHER_DIR)

$(FISHER_DIR):
	curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
	mkdir -p $(FISHER_DIR)

.PHONY: fisher-update
fisher-update:
