#!/bin/sh

## selected-gui-tools.sh ## you should customize this for you
# @see: https://github.com/caskroom/homebrew-cask/tree/master/Casks

# taps
brew tap caskroom/versions;
brew tap caskroom/fonts;

# browsers
brew cask install multifirefox;
# brew cask install firefox;
brew cask install chrome;
brew cask install chrome-devtools;
brew cask install google-chrome-canary; # requires: versions

# editors & IDEs
brew cask install sublime-text3; # requires: versions
brew cask install coda; # paid/trial

# file & data tools
brew cask install cyberduck;
brew cask install sequel-pro;

# source control
brew cask install sourcetree;
brew cask install svnx;

# power tools
brew cask install alfred;
brew cask alfred link;
brew cask install kaleidoscope; # paid/trial
brew cask install vlc;

# virtualization
# brew cask install parallels-desktop; # paid/trial
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