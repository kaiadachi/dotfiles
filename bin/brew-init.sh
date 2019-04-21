#!/bin/bash
source $(dirname $0)/.init.sh

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
cd $PACKAGE_HOMEBREW_DIR && brew bundle dump
