#!/bin/sh

## lamp.sh ## We are not using any mac/MAMP tools.
# Instead we homebrew our own LAMP stack using standard linux folder locations.
# Based on: https://iyware.com/osx-yosemite-mamp-homebrew-development-setup/
# And: https://gilmendes.wordpress.com/2014/07/09/install-nginx-php-fpm-mysql-and-phpmyadmin-on-os-x-yosemite
##

s_title='Customizable Homebrew LAMP Stack (for Mac OSX 10.10 Yosemite)';

# "Welcome, let me introduce myself!"
echo -e "<\x1b[01mlamp.sh\x1b[0m>\x1b[01m";
echo -e "$s_title\x1b[0m";
echo -e "based on: \x1b[34;04mhttps://iyware.com/osx-yosemite-mamp-homebrew-development-setup/\x1b[0m";
echo
echo -e "$e_info this script is a tool for developers to save time";
echo -e "$e_info some beginners may find this useful for getting setup";
echo -e "$e_warn however, this is NOT a supported installation tool";
echo -e "$e_warn \x1b[30;01mplease DO NOT\x1b[0m: ask this repo for help setting up your machine. =/";
echo -e "$e_success the tutorial above definitely has a discussion thread =]";
echo -e "$e_success \x1b[30;01mplease DO\x1b[0m: contribute improvements and fork to version & store your setup =]";
echo -e "$e_input Press [Enter] key to continue...";
read

### dependancies ###
source xcode-clt.sh
source brew.sh
### /dependancies ###

### are you sure? ###
# that you want to do all this? well probably...
# but install scripts with no cancel button are just insane!
while true; do
    echo -e  "$e_input would you like to install $s_title?"
    read -p "" yn;
    case $yn in
        [Yy]* ) break;;
		[n]* ) echo "$e_info okay, okay. i get it. was it me?"; break;;
		* ) echo "you quit... this time i win!"; return;;
    esac
done
### /here we go! ###

### Tap Repos ###
brew tap homebrew/dupes;
brew tap homebrew/versions;  
brew tap homebrew/homebrew-php;  
brew tap homebrew/apache;  
brew update && brew upgrade;  
### /Tap Repos ###

### Mac Crap ###
# i said "let me introduce myself"
echo -e "$e_info installing 'git' and 'openssl' (the linux way and disabling mac stuff)";
brew install git;  
brew install openssl;
# check for and existing ssh key
if [[ $( cat ~/.ssh/id_rsa.pub ) == *"ssh-rsa"*"@"* ]]
then
	echo -e "$e_info you have an existing key in: /.ssh/id_rsa.pub";
	echo -e "$e_warn unless you know what you're doing. DO NOT generate a new one.";
	recommended="$e_warn This is NOT recommended (key is easily overwritten).";
else
	echo -e "";
	recommended="$e_warn This is HIGHLY recommended (you need this!)."
fi
echo -e "$e_info more on SSH keys: https://help.github.com/articles/generating-ssh-keys/";
# offer to generate recommending (not forcing) an option
while true; do
    echo -e "$e_input do you wish to install generate a new SSH key?";
    echo -e "$recommended"
    read -p "y/n: " yn;
    case $yn in
        [Yy]* ) while true; do
				    echo -e "What is your primary email (for Github & SVN)?";
				    read -p "(user@domain.com):" email;
				    ssh-keygen -t rsa -C "$email";
					if [ -z "$SSH_AUTH_SOCK" ] ; then
					    eval `ssh-agent -s`
					fi
					ssh-add ~/.ssh/id_rsa;
					echo -e "$e_success you may want to copy and paste this now or";
					echo -e "$e_info add it to the clipboard later using: pbcopy < ~/.ssh/id_rsa.pub";
					echo "---public key start---";
					cat ~/.ssh/id_rsa.pub;
					echo "---public key end---";
				done
				break;;
		* ) break;;
    esac
done
### /Mac Crap ###

### Apache ### 
# i said "let me introduce myself"
echo -e "$e_info installing 'apache' (the linux way and disabling mac 'apache')";
# Cuz, I mean, who want's unexpected password prompts, like evar?
echo -e "$e_warn you know Apache, the 'sudoing' starts here"
echo -e "$e_warn you will be prompted (by your laptop) for your password";
# Stop existing apache and stop it's auto start 
sudo apachectl stop;
sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist 2>/dev/null;
# Install apache's httpd product
brew install httpd24 --with-privileged-ports --with-brewed-ssl;
# Setup auto start
sudo cp -v /usr/local/Cellar/httpd24/2.4.10/homebrew.mxcl.httpd24.plist /Library/LaunchDaemons;
sudo chown -v root:wheel /Library/LaunchDaemons/homebrew.mxcl.httpd24.plist;
sudo chmod -v 644 /Library/LaunchDaemons/homebrew.mxcl.httpd24.plist;
sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.httpd24.plist;  
sudo httpd -k start;
### /Apache ### 

### MariaDB ###
# i said "let me introduce myself"
echo -e "$e_info installing MariaDB (the linux way)";
# you are assumed to be smart, i just like to be clear
echo -e "$e_warn please note the database 'root' user is NOT your system 'root' user.";
echo -e "$e_warn having the same name, this can be a point of confusion.";
brew install mysql;
# Setup auto start
ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents;
# And start the database server:
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist;
## Secure mysql (yes optionally. grumble, grumble)
echo -e "$e_info 'mysql_secure_installation' will change the root password, remove anonymous users and disable remote logins";
while true; do
    echo -e "$e_input would you like to run 'mysql_secure_installation' (HIGHLY recommended)?";
    read -p "y/n: " yn;
    case $yn in
        [Yy]* ) mysql_secure_installation
			echo -e "$e_info about to test your new root password.";
			echo -e "$e_info after login. type '\q' at the 'mysql>' prompt to exit MariaDB and move on.";
			mysql -uroot -p
		* ) echo -e "$e_warn not securing database. you can always run 'mysql_secure_installation' later."; break;;
    esac
done
### /MariaDB ###

### PHP 5.6 ###
# i said "let me introduce myself"
echo -e "$e_info installing 'php56' (the linux way and setup 'apache' to use 'php56')";
brew install php56 --homebrew-apxs --with-apache --with-homebrew-curl --with-homebrew-openssl --with-phpdbg --with-tidy --without-snmp;
chmod -R ug+w /usr/local/Cellar/php56/5.6.2/lib/php;
# configure apache
pear config-set php_ini /usr/local/etc/php/5.6/php.ini;
printf '\nAddHandler php5-script .php\nAddType text/html .php' >> /usr/local/etc/apache2/2.4/httpd.conf;
perl -p -i -e 's/DirectoryIndex index.html/DirectoryIndex index.php index.html/g' /usr/local/etc/apache2/2.4/httpd.conf;
# update path
printf '\nexport PATH="$(brew --prefix homebrew/php/php56)/bin:$PATH"' >> ~/.profile;
### /PHP 5.6 ###

### Dev Stuff ###
# i said "let me introduce myself"
echo -e "$e_info installing dev tools"
# please modify or comment this line when changing the dev tools so the user (possibly you) isn't mislead
echo -e "$e_info including: 'composer', 'behat', 'node', 'grunt', 'shifter', 'moodle-sdk', 'autoconf', & 'phpmyadmin'";
echo -e "$e_info this script isn't interactive and assumes you've commented/removed stuff you don't want and added what you do";
brew install composer;
brew install behat;
brew install node;  
npm -g install grunt;  
npm -g install shifter;  
brew tap danpoltawski/homebrew-mdk;  
brew install moodle-sdk;
## phpMyAdmin ##
# Install autoconf which you need for the installation of phpMyAdmin
brew install autoconf;
# Set $PHP_AUTOCONF. For bash users
echo 'PHP_AUTOCONF=&quot;'$(which autoconf)'&quot;' >> ~/.profile;
# Install phpMyAdmin
brew install phpmyadmin;
## /phpMyAdmin ##
### /Dev Stuff ###

# just like it says  
brew cleanup;
echo
echo -e "$e_info script has completed.";
echo -e "$e_info homebrew has fairly clear error reporting.";
echo -e "$e_info we don't need to parse all that and tell you if everything succeed.";
echo -e "$e_info please scroll up to check for errors and test thoroughly.";




