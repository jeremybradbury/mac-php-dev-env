#!/bin/sh

## selected-gui-tools.sh ## you should customize this for you
# @see: https://github.com/caskroom/homebrew-cask/tree/master/Casks
##
## taps ##
brew tap caskroom/versions;
# i wanna 'brew cask search /font/' & 'brew cask install font-*' later, even if not below
brew tap caskroom/fonts; # this is time consuming best get it out of the way now
##
## browsers ##
brew cask install multifirefox; # version/profile loader allowing multiple browser instances
brew cask install firefox;
brew cask install chrome;
brew cask install chrome-devtools;
brew cask install google-chrome-canary; # requires: versions
##
## editors & IDEs ##
brew cask install sublime-text3; # requires: versions
## i wanna 'sublime /etc/hosts' & 'sublime ~/repos/<folder>/' on a regular =]
ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/sublime; # command line tools
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
brew cask alfred link; # alfred needs love too
brew cask install charles # shareware
brew cask install coderunner; # paid/trial $9.99
brew cask install dash; # paid/trial $9.99
brew cask install kaleidoscope; # paid/trial $69.99
### kaleidoscope command line tools ###
brew cask install ksdiff; 
# i wanna make *everything* use kaleidoscope instead of opendiff
ORIG=$(which opendiff); 
sudo mv $ORIG $(which opendiff).apple; # rename opendiff
sudo ln -sfv $(which ksdiff) $ORIG; # point it to ksdiff
### /kaleidoscope command line tools ###
brew cask install microsoft-office; # paid/trial
brew cask install moom; # paid/trial $10.00
#brew cask install openoffice;
brew cask install remote-desktop-connection; # m$ client
brew cask install vlc;
##
## virtualization ##
#brew cask install parallels-desktop; # paid/trial
brew cask install vagrant;
brew cask install vagrant-manager;
brew cask install vagrant-bar;
brew cask install virtualbox;
## manual post script ops ##
# TODO: at the very least provide scripting/docs for these processes
### setup office VPN
### get Cisco AnyConnect
### register paid stuff
##