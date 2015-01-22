#!/bin/sh

## gui-tools.sh ## A wrapper for our GUI tools install script
# we use homebrew's caskroom to install browsers, editors and
# other tools in the customizable file: selected-gui-tools.sh
##
source colors.sh;
s_title='Customizable Homebrew LAMP Stack (for Mac OSX 10.10 Yosemite)';
s_ref='http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac';
## "Welcome, let me introduce myself!"
echo -e "<\x1b[01mgui-tools.sh\x1b[0m>\x1b[01m";
echo -e "$s_title\x1b[0m";
echo -e "based on: \x1b[34;04m$s_ref\x1b[0m";
echo
echo -e "$e_info this script is a tool for developers to save time";
echo -e "$e_info some beginners may find this useful for getting setup";
echo -e "$e_warn however, this is NOT a supported installation tool";
echo -e "$e_warn \x1b[30;01mplease DO NOT\x1b[0m: ask this repo for help setting up your machine. =/";
echo -e "$e_success the tutorial above definitely has a discussion thread =]";
echo -e "$e_success \x1b[30;01mplease DO\x1b[0m: contribute improvements and fork to version & store your setup =]";
echo -e "$e_input Press [Enter] key to continue...";
read
##
## dependencies
echo -e "$e_info checking dependencies";
source xcode-clt.sh;
source brew.sh;
source cask.sh;
## 
## review/install customizable gui dev tools 
echo -e "$e_info The following is an output of your customizable install script: selected-gui-tools.sh.";
echo -e "$e_input Press [Enter] key to continue...";
read
echo "*** BOF";
cat selected-gui-tools.sh;
echo
echo "*** EOF";
while true; do
    echo -e "$e_input are you sure you wish to install the selected GUI tools above?";
    read -p "" yn
    case $yn in
        [Yy]* ) echo -e "$e_info begin custom GUI tools install script"; 
        		source selected-gui-tools.sh; 
				brew cask cleanup; # ooh i wasn't expecting company, let me pickup a few things
				echo -e "$e_info end custom GUI tools install script"; 
				break;;
        * ) echo -e "$e_info you'll be back! ...right?"; break;;
    esac
done