#!/bin/sh

## install.sh ## installation wrapper menu for the script library
# 
##
source colors.sh;
s_title='Development Environment Provisioning for Mac OSX 10.10 (Yosemite)';
source func.sh;
clear;
draw_menu;
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