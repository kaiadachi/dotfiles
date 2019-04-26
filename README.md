# Policy
Installing packages, applications for MacOS will be by brew 
Expanding dotfiles, plugins will be by make 

Initialize = Do only the first time for installing 
Update = Change setting or add plugins 
Clean = Delete Repository 

# First Settings

## clone
git clone git@github.com:kaiadachi/dotfiles.git 
cd dotfiles

## packages, applications initialize
$ bash bin/brew-init.sh

## dotfiles, plugins initialize
$ make


# Update

## you change to write some dotfiles
$ make update

# Clean

## you clean up your env
$ make clean

# Reference
https://github.com/bto/dotfiles  
https://github.com/takeokunn/dotfiles
