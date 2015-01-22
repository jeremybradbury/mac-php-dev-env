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
echo -e "$e_info otherwise we're about to start the install";
echo -e "$e_input is there any red? should we bail and come back?";
read -p "" yn
case $yn in
    [Yy]* ) return;; 
    * ) ;;
esac

echo -e "$e_warn we are about to run 'sudo echo' which will prompt you";
echo -e "$e_warn for your password and print a note about what's next";
echo -e "$e_info so you aren't promted during the script";
echo -e "$e_info many of the apps you isntall will need to 'sudo'";
sudo echo -e "$e_info now... go get some coffee or take a nap and come back";