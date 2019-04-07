#!/bin/bash
source $(dirname $0)/.init.sh

while read pkg; do
    brew install $pkg
done < $CONFIG_HOMEBREW_DIR/pkgs.txt
