#!/bin/sh
## brew.sh ## A dependency include for checking/installing homebrew
# homebrew - you need this - its a package manager for installing command line tools
source colors.sh;
if [[ $(which brew) ]]
then
    echo -e "$e_success 'homebrew' is already installed: $(which brew)";
    echo -e "$e_warn turn your head and cough!";
	if [[ $(brew doctor) == *"ready to brew." ]]
	then 
		echo -e "$e_success you passed brew doctor's exam!";
	else
		echo -e "$e_error 'brew doctor' has some bad news: ";
		brew doctor;
		while true; do
		    echo -e "$e_input ignore this and try to move on (not recommended)?";
		    read -p ":" yn
		    case $yn in
		        [Yy]* ) echo -e "$e_warn ignoring above 'brew doctor' complaints... "; return; break;;
				* ) echo -e "$e_info Let's get this resolved, then try this again, shall we?"; exit;;
		    esac
		done
	fi
else
	while true; do
	    echo -e "$e_input do you wish to install 'homebrew' (you need this)?";
		read -p ":" yn
	    case $yn in
	        [Yy]* ) ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"; 
					brew update && brew upgrade; 
					echo -e "$e_warn turn your head and cough!";
					if [[ $(brew doctor) == *"ready to brew." ]]
					then 
						echo -e "$e_success you successfuly installed 'homebrew'";
						echo -e "$e_success you passed brew doctor's exam!"; return;
					else
						echo -e "$e_error 'brew doctor' has some bad news: ";
						brew doctor;
						while true; do
						    echo -e "$e_input ignore this and try to move on (not recommended)?";
						    read yn2;
						    case $yn2 in
						        [Yy]* ) echo -e "$e_warn ignoring above 'brew doctor' complaints... "; break;;
								* ) echo -e "$e_info Let's get this resolved, then try this again, shall we?"; exit;;
						    esac
						done
					fi;; 
			* ) break;;
	    esac
	done
fi 
echo -e "$e_warn 'sudo echo' will prompt you for your password now";
echo -e "$e_info so (hopefully) you aren't promted during the script";
sudo echo -e "$e_info now... go get some coffee or take a nap and come back";