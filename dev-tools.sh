#!/bin/sh
## dev-tools.sh ###
source colors.sh;
# "let me introduce myself"
echo -e "$e_info installing additional dev tools (if you didn't install lamp.sh these wont work)"
# please modify or comment this line when changing the dev tools so the user (possibly you) isn't mislead
echo -e "$e_info including: 'composer', 'behat', 'node', 'grunt', 'shifter', 'moodle-sdk', 'autoconf', & 'phpmyadmin'";
echo -e "$e_info this script isn't interactive and assumes you've commented/removed stuff you don't want and added what you do";
echo -e "$e_input Press [Enter] to continue...";
read;
brew install composer;
brew install behat;
brew install node;  
npm -g install grunt;  
npm -g install shifter;   
brew install moodle-sdk;
## phpMyAdmin ##
# Install autoconf which you need for the installation of phpMyAdmin
brew install autoconf;
# Set $PHP_AUTOCONF. For bash users
echo "PHP_AUTOCONF='$(which autoconf)'" >> ~/.profile;
# Install phpMyAdmin
brew install phpmyadmin;
## /phpMyAdmin ##
brew cleanup;
## terminal ## 
echo "
# custom terminal
export PS1='\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ '
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh'
" >> ~/.profile;
open jeremy.terminal; # i like my standard Terminal, but sexy like
## /terminal ##
### /Dev Stuff ###