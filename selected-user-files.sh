#!/bin/sh
source colors.sh;
## selected-user-files.sh ## A wrapper for our user files import
##
## hello!
echo -e "$e_info You'll really want to fork me first, then edit =)";
echo -e "$e_info Thus, creating yourself a custom provisioning tool via GitHub.";
echo -e "$e_info When migrating, just import your home folder first, now it's become a powerful system recovery.";
##
## select the backup folder
echo -e "e_warn make sure your backups aren't getting written to in 'selected-user-files.sh'";
echo -e "e_input where is your backup file?";
read ": " backup;
#backup="~/Desktop/jeremy"; # manual override
##
## selected destination files/folders
cp "$backup/Desktop/*" ~/Documents/
cp "$backup/Downloads/*" ~/Downloads/
cp "$backup/Library/Keychains/login.keychain" ~/Library/Keychains/login.keychain
cp "$backup/Library/Application\ Support/*" "~/Library/Application\ Support/"
cp "$backup/Library/Fonts/*" ~/Library/Fonts/
cp "$backup/Music/*" ~/Music/
cp "$backup/Pictures/*" ~/Pictures/
cp "$backup/.ssh/*" ~/.ssh/
cp "$backup/.subversion/*" ~/.subversion/
cp "$backup/.vagrant.d/*" ~/.vagrant.d/
cp "$backup/.git_config" ~/.git_config
cp "$backup/.gitignore_global" ~/.gitignore_global
cp "$backup/.profile" ~/.profile
cp "$backup/.vminfo" ~/.vminfo
#cp "$backup/Desktop" ~/Desktop; # i ususally keep my backups here and not much else
##