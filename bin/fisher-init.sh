#!/bin/bash
source $(dirname $0)/.init.sh

while read pkg; do
    fish -c fisher add $pkg
done < $PACKAGE_FISHER_DIR/pkgs.txt
