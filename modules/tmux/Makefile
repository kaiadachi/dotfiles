TMUX_DIR = ~/.tmux/plugins/tpm
TMUX_GITHUB_URL = https://github.com/tmux-plugins/tpm

# CLEAN_TARGETS += tmux-clean
# INITIALIZE_TARGETS += tmux-init
# UPDATE_TARGETS += tmux-update

.PHONY: tmux-clean
tmux-clean:
	rm -rf $(TMUX_DIR)

tmux-init: $(TMUX_DIR)

$(TMUX_DIR):
	git clone $(TMUX_GITHUB_URL) $(TMUX_DIR)
	tmux source ~/.tmux.conf

tmux-update:
	tmux source ~/.tmux.conf
