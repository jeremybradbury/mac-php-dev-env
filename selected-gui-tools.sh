#!/bin/sh
## selected-gui-tools.sh ## you should customize this for you
# @see: https://github.com/caskroom/homebrew-cask/tree/master/Casks
##
## hey there!
echo -e "$e_info You'll really want to fork me first, then edit =)";
echo -e "$e_info Thus, creating yourself a custom provisioning tool via GitHub.";
echo -e "$e_info When migrating, just import your home folder first, now it's become a powerful system recovery.";
##
## taps ##
brew tap caskroom/versions;
# i wanna 'brew cask search /font/' & 'brew cask install font-*' later, even if not below
brew tap caskroom/fonts; # this is time consuming best get it out of the way now
##
## backward compatibility
brew cask install xquartz; 
##
## browsers ##
brew cask install multifirefox; # version/profile loader allowing multiple browser instances
brew cask install firefox;
brew cask install google-chrome;
brew cask install chrome-devtools;
brew cask install google-chrome-canary; # requires: versions
##
## editors & IDEs ##
brew cask install sublime-text3; # requires: versions
## i wanna 'sublime /etc/hosts' & 'sublime ~/repos/<folder>/' on a regular =] (the brew cask way)
mv /usr/local/bin/subl /usr/local/bin/sublime # rename command line tools
brew cask install coda; # paid/trial
## i wanna 'coda /var/www/<folder>/' & 'coda < config.yaml > config_new.yaml' on a regular too =]
brew install coda-cli; # command line tools: http://justinhileman.info/coda-cli/
##
## file & data tools ##
brew cask install cyberduck;
brew cask install sequel-pro;
##
## graphics ##
brew cask install gimp;
#brew cask install adobe-creative-cloud; # paid/trial 
#brew cask install adobe-digital-editions; # paid/trial
#brew cask install adobe-photoshop-lightroom; # paid/trial
##
## visual source control
brew cask install sourcetree;
# i wanna 'sourcetree ~/repos/<path>' so we can switch to or create new repos
echo "
# sourcetree
alias sourcetree='open -a SourceTree ' 

" >> ~/.profile; 
brew cask install svnx; 
##
## productivity ##
brew cask install alfred; 
# https://github.com/caskroom/homebrew-cask/issues/8052#issuecomment-70960767
# brew cask alfred link; # deprecated if alfred doesn't find cask apps later: see above comment
brew cask install charles # shareware
brew cask install coderunner; # paid/trial $9.99
brew cask install dash; # paid/trial $9.99
#brew cask install kaleidoscope; # paid/trial $69.99 # i have in the mac store instead =/
### kaleidoscope command line tools ###
brew cask install ksdiff; 
# i wanna make *everything* use kaleidoscope instead of opendiff
ORIG=$(which opendiff); 
sudo mv $ORIG $(which opendiff).apple; # rename opendiff
sudo ln -sfv $(which ksdiff) $ORIG; # point it to ksdiff
### /kaleidoscope command line tools ###
brew cask install microsoft-office; # paid/trial
#brew cask install moom; # paid/trial $10.00 # i have in the mac store instead =/
#brew cask install openoffice; # i use office
brew cask install remote-desktop-connection; # m$ client
brew cask install vlc;
##
## virtualization ##
#brew cask install parallels-desktop; # paid/trial
brew cask install vagrant;
brew cask install vagrant-manager;
#brew cask install vagrant-bar; # manager seems better
brew cask install virtualbox;
## manual post script operations ##
# TODO: at the very least provide scripting/docs for these processes
echo -e "$e_info please install Mac Store Apps"; # like this
open /Applications/App\ Store.app;
### setup office VPN
### get Cisco AnyConnect
### register paid stuff
### manage icon dock
### setup chat and email
##