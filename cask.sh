#!/bin/sh
 
## cask.sh ## A dependancy include for checking/installing homebrew
# cask - you need this - its a package manager for installing GUI tools
if [[ $( brew cask list ) == *"Unknown command: cask"* ]]
then
	while true; do
	    echo -e "$e_input do you wish to install 'homebrew cask' (you need this)?";
		read -p "" yn;
	    case $yn in
	        [Yy]* ) brew install caskroom/cask/brew-cask;
					break;; 
			* ) break;;
	    esac
	done
fi
if $( brew cask list ) -ne *"Unknown command: cask"*;
then
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