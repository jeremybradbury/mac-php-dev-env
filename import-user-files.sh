#!/bin/sh
source colors.sh;
s_title='Import User Files (designed in/for Mac OSX 10.10 Yosemite)';
## import-user-files.sh ## A wrapper for our user files import
##
# selective user import script, as in: 
## (un)comment lines to '(un)select'
## add/change lines as needed
echo -e "e_info you are about to read the import script and confirm."
echo -e "e_inpur Press [enter] to continue... ";
read;
cat selected-import.sh;
while true; do
    echo -e "$e_input are you sure you wish to import to selected destination files/folders above?";
    read -p ":" yn
    case $yn in
        [Yy]* ) echo -e "$e_info begin $s_title script"; 
        		source selected-user-files.sh; 
				echo -e "$e_info end $s_title script"; 
				break;;
        * ) echo -e "$e_info yeah, you should only run this once"; break;;
    esac
done
read;