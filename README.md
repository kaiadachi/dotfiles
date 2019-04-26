# Policy
Installing packages, applications for MacOS will be by brew  
Expanding dotfiles, plugins will be by make  
  
Initialize = Do only the first time for installing  
Update = Change setting or add plugins  
Clean = Delete what was born from this repository

# First Settings

## brew install
$ curl -L https://raw.githubusercontent.com/kaiadachi/dotfiles/master/bin/brew-init.sh | bash

## packages, application initialize
$ git clone https://github.com/kaiadachi/dotfiles.git
$ cd dotfiles  
$ bash bin/brew-init.sh

## dotfiles, plugins initialize
$ make


# Update

## change to write some dotfiles
$ make update

# Clean

## clean up your env
$ make clean

# Reference
https://github.com/bto/dotfiles  
https://github.com/takeokunn/dotfiles
