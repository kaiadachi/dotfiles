# #!/bin/bash
source $(dirname $0)/.init.sh

# brew install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# brew Applications install
cd $PACKAGE_HOMEBREW_DIR && brew bundle dump
