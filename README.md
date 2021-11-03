# Policy
Installing packages, applications for MacOS will be by brew  
Expanding dotfiles, plugins will be by make  

Initialize: Do only the first time for installing  
Update: Change setting or add plugins  
Clean: Delete what was born from this repository

# First Settings

## brew initialize(show Brewfile)
$ curl -L https://raw.githubusercontent.com/kaiadachi/dotfiles/master/bin/brew-init.sh | bash  
or  
$ git clone https://github.com/kaiadachi/dotfiles.git  
$ cd dotfiles  
$ bash bin/brew-init.sh

## dotfiles, plugins initialize
$ make init

# Clean

## clean up your env
$ make clean

# notices
1101exclude: emacs,tmux
tmux plugin: prefix + I
