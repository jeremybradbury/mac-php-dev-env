#!/bin/sh

## xcode-clt.sh ## A dependancy include for checking/installing 
# xcode command line tools - you will need this
if [[ $( xcode-select -p ) == *"/"* ]]
then
    echo -e "$e_success 'xcode command line tools' are already installed: $( xcode-select -p )";
else
	while true; do
    echo -e "$e_input would you like to install 'xcode command line tools' (you need this)?";
    read -p yn
    case $yn in
        [Yy]* ) echo "Click only the 'install' button in the following dialog"; xcode-select --install; break;;
		* ) break;;
    esac
done
fi 