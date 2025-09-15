This repository is a bare git repo that contains all of my configuration files (dotfiles) so that I can carry them around to my various computers.

Because this is a bare git repos we need to use a special command to git the repo into place. 

git --git-dir=dotfiles --work-tree=$HOME clone 

later this command becomes shortened via .bash_alias to config 
