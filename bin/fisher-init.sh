#!/bin/bash
source $(dirname $0)/.init.sh

while read pkg; do
  fish -c "fisher install $pkg"
done < $PACKAGE_FISHER_DIR/pkgs.txt
