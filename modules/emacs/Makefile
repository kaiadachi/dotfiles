EMACS_DIR = ~/.emacs.d
SELF_EMACS_DIR = $(MODULE_DIR)/emacs

CLEAN_TARGETS += emacs-clean
INITIALIZE_TARGETS += emacs-init
UPDATE_TARGETS += emacs-update

.PHONY: emacs-clean
emacs-clean:
	rm -rf $(EMACS_DIR)

.PHONY: emacs-init
emacs-init: $(emacs_DIR)

$(EMACS_DIR):
	mkdir -p $(EMACS_DIR)

	ln -sf $(SELF_EMACS_DIR)/init.el $(EMACS_DIR)/
	ln -sf $(SELF_EMACS_DIR)/Cask $(EMACS_DIR)/
	ln -sf $(SELF_EMACS_DIR)/config $(EMACS_DIR)/
	
	$(EMACS_DIR)/cask install

emacs-update:
	$(EMACS_DIR)/cask update
