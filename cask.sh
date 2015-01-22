#!/bin/sh
 
## cask.sh ## A dependancy include for checking/installing homebrew
# cask - you need this - its a package manager for installing GUI tools
echo "$s_info is 'homebrew-cask' installed?";
brew cask list;
while true; do
    echo -e "$e_input do you wish to install 'homebrew-cask' (you’ll need this)?";
    read -p "" yn
    case $yn in
        [Yy]* ) brew install caskroom/cask/brew-cask; echo "attempted"; break;; 
        * ) break;;
    esac
done
brew cask update;
echo -e "$e_warn turn your head and cough!";
brew cask doctor;
echo -e "$e_info you'll need to review the above and resolve any issues";
echo -e "$e_input is there any red? should we bail and come back?";
read -p "" yn;
case $yn in
[Yy]* ) return; break;; 
* ) break;;
esac
# needed for backward compatibility
brew cask install xquartz; 