#!/bin/sh 
source colors.sh;
## selected-user-files.sh ## CUSTOMIZE THIS FOR YOU!! ##
##
## hello!
echo -e "$e_info You'll really want to fork me first, then edit =)";
echo -e "$e_info Thus, creating yourself a custom provisioning tool via GitHub.";
##
## select the backup folder
echo -e "$e_warn make sure your backups aren't getting written to in 'selected-user-files.sh'";
echo -e "$e_warn dont use '~'' like this:~/Desktop/jeremy";
echo -e "$e_input where is your old user folder (like this:/Users/jeremy/Desktop/jeremy)?"
read -p ":" backup;
#backup="~/Desktop/jeremy"; # manual override
## selected destinations
### R = recursive
### p = preserve file/user meta
### n = never overrwite
### v = verbose (tell me all about it, so i don't think it's stuck)
# folders
cp -Rpnv $backup/Documents ~/Documents;
cp -Rpnv $backup/Downloads ~/Downloads;
cp -Rpnv $backup/Library/Application\ Support ~/Library/Application\ Support; # this one can take a long time!
cp -Rpnv $backup/Library/Fonts ~/Library/Fonts;
cp -Rpnv $backup/Music ~/Music;
cp -Rpnv $backup/Pictures ~/Pictures;
cp -Rpnv $backup/.ssh ~/.ssh;
cp -Rpnv $backup/.subversion ~/.subversion;
cp -Rpnv $backup/.vagrant.d ~/.vagrant.d;
# files
cp -pnv $backup/Library/Keychains/login.keychain ~/Library/Keychains;
cp -pnv $backup/.gitconfig ~;
cp -pnv $backup/.gitignore_global ~;
cp -pnv $backup/.profile ~;
cp -pnv $backup/.viminfo ~;
#cp -Rpn $backup/Desktop ~/Desktop; # i ususally keep my backups here and not much else
##