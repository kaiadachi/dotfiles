.PHONY: all
all: install

TOP_DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
BIN_DIR = $(TOP_DIR)/bin
PACKAGE_DIR = $(TOP_DIR)/packages
MODULE_DIR = $(TOP_DIR)/modules
SOURCE_DIR = $(TOP_DIR)/src

CLEAN_TARGETS +=
INSTALL_TARGETS +=
UPDATE_TARGETS +=

-include $(SOURCE_DIR)/make/*.mk
-include $(MODULE_DIR)/*/Makefile

.PHONY: clean
clean: $(CLEAN_TARGETS)

.PHONY: install
install: $(INSTALL_TARGETS)

.PHONY: update
update: $(UPDATE_TARGETS)
