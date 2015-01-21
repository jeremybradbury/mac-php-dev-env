#!/bin/sh

## install.sh ## installation wrapper menu for the script library
# 
##

### constants ###
e_error='\x1b[31;01m[error]:\x1b[0m'            # red
e_warn='\x1b[33;01m[warning]:\x1b[0m'           # yellow
e_success='\x1b[32;01m[success]:\x1b[0m'        # green
e_info='\x1b[30;01m[inform]:\x1b[0m'            # black
e_input='\x1b[34;01m[input required]:\x1b[0m'   # blue
s_title='Development Environment Provisioning for Mac OSX 10.10 (Yosemite)';
### /constants ###

### dependancies ###
source draw-menu.sh;
### /depedancies ###

clear
draw_menu
echo "${scripts[0]}";
while true; do
    echo -e "$e_input what script would you like to run";
	read -p "" scri;
    case $scri in
	    l) source lamp.sh; return; break;;
	    n) source nginx.sh; return; break;;
        g) source gui-tools.sh; return; break;;
		*) return; break;;
    esac
done