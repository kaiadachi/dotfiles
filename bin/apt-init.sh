#!/bin/bash
source $(dirname $0)/.init.sh

while read repo; do
    sudo apt-add-repository-y $repo
done < $PACKAGE_APT_DIR/repos.txt

while read pkg; do
    sudo apt install -y $pkg
done < $PACKAGE_APT_DIR/pkgs.txt
