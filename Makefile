.PHONY: all
all: init

TOP_DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
BIN_DIR = $(TOP_DIR)/bin
PACKAGE_DIR = $(TOP_DIR)/packages
MODULE_DIR = $(TOP_DIR)/modules
SOURCE_DIR = $(TOP_DIR)/src

CLEAN_TARGETS +=
INITIALIZE_TARGETS +=
UPDATE_TARGETS +=

-include $(SOURCE_DIR)/make/*.mk
-include $(MODULE_DIR)/*/Makefile

.PHONY: clean
clean: $(CLEAN_TARGETS)

.PHONY: init
init: $(INITIALIZE_TARGETS)

.PHONY: update
update: $(UPDATE_TARGETS)
