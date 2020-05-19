#!/bin/sh
## lamp.sh ## We are not using any mac/MAMP tools.
# Instead we homebrew our own LAMP stack using standard linux folder locations.
# The guys at echo have built a really good script, but it's in the form of read then copy (which is super nice!)
# However, our goal is automation here and the article is documented really well: comments here are limited. 
# Based on: https://echo.co/blog/os-x-1010-yosemite-local-development-environment-apache-php-and-mysql-homebrew
# And a few random other collections pulled from my brain and laptop at the bottom =]
##
source colors.sh;
s_title='Customizable Homebrew LAMP Stack (for Mac OSX 10.10 Yosemite)';
s_ref='https://echo.co/blog/os-x-1010-yosemite-local-development-environment-apache-php-and-mysql-homebrew';
#
### intro ###
echo -e "<\x1b[01mlamp.sh\x1b[0m>\x1b[01m";
echo -e "$s_title\x1b[0m";
echo -e "based on: \x1b[34;04m$s_ref\x1b[0m";
echo
echo -e "$e_info this script is a tool for developers to save time";
echo -e "$e_info some beginners may find this useful for getting setup";
echo -e "$e_warn however, this is NOT a supported installation tool";
echo -e "$e_warn \x1b[30;01mplease DO NOT\x1b[0m: ask this repo for help setting up your machine. =/";
echo -e "$e_success the tutorial above definitely has a discussion thread and loads more documentation and explanation =]";
echo -e "$e_success \x1b[30;01mplease DO\x1b[0m: contribute improvements and fork to version & store your setup =]";
echo -e "$e_input Press [Enter] key to continue...";
read
### /intro ###
#
### dependency ###
source brew.sh;
### /dependency ###
#
### are you sure? ###
# that you want to do all this? well probably...
# but install scripts with no cancel button are just insane!
while true; do
    echo -e  "$e_input would you like to install $s_title?"
    read -p "" yn;
    case $yn in
        [Yy]* ) break;;
		[n]* ) echo "$e_info okay, okay. i get it. was it me?"; break;;
		* ) echo "you quit... i win... this time..."; return;;
    esac
done
### /here we go! ###
#
### Tap Repos ###
brew tap homebrew/dupes;
brew tap homebrew/versions;  
brew tap homebrew/homebrew-php;  
brew tap homebrew/apache;
brew tap danpoltawski/homebrew-mdk;  
brew update && brew upgrade;  
### /Tap Repos ###
#
### Mac Stuff ###
# i said "let me introduce myself"
echo -e "$e_info installing 'git'";
brew install git;  
# aliases
echo "#homebrew
export PATH='/usr/local/sbin:$PATH';

# git
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout '
alias gsc='git rev-parse --short HEAD | xargs echo -n | pbcopy' # copy short commit hash to clipboard
" >> ~/.profile;

### /Mac Stuff ###
#
### MySQL ###
# i said "let me introduce myself"
echo -e "$e_info installing MySQL (the linux way)";
brew install -v mysql;
cp -v $(brew --prefix mysql)/support-files/my-default.cnf $(brew --prefix)/etc/my.cnf;
cat >> $(brew --prefix)/etc/my.cnf <<EOF
 
# Echo & Co. changes
max_allowed_packet = 1073741824
innodb_file_per_table = 1
EOF
sed -i '' 's/^#[[:space:]]*\(innodb_buffer_pool_size\)/\1/' $(brew --prefix)/etc/my.cnf;
# Setup auto start
[[ ! -d ~/Library/LaunchAgents ]] && mkdir -v ~/Library/LaunchAgents;
ln -sfv $(brew --prefix mysql)/homebrew.mxcl.mysql.plist ~/Library/LaunchAgents/;
# And start the database server:
launchctl load -Fw ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist;
# Secure mysql 
$(brew --prefix mysql)/bin/mysql_secure_installation;
# aliases
echo "# MySQL
alias mysql.start='brew services start mysql'
alias mysql.stop='brew services stop mysql'
alias mysql.restart='brew services restart mysql'
" >> ~/.profile;
### /MySQL ###
#
### Apache ### 
# i said "let me introduce myself"
echo -e "$e_info installing 'apache' (the linux way and disabling mac 'apache')";
# Stop existing apache and stop it's auto start 
sudo apachectl stop;
sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist 2>/dev/null;
# Install apache's httpd product
brew install -v homebrew/apache/httpd22 --with-brewed-openssl --with-mpm-event;
# fastcgi not mod_php
brew install -v homebrew/apache/mod_fastcgi --with-brewed-httpd22;
cp $(brew --prefix)/etc/apache2/2.2/httpd.conf $(brew --prefix)/etc/apache2/2.2/httpd.conf.bak;
sed -i '' '/fastcgi_module/d' $(brew --prefix)/etc/apache2/2.2/httpd.conf;
(cat >> $(brew --prefix)/etc/apache2/2.2/httpd.conf <<EOF
 
# Echo & Co. changes
 
# Load PHP-FPM via mod_fastcgi
LoadModule fastcgi_module    $(brew --prefix mod_fastcgi)/libexec/mod_fastcgi.so
 
<IfModule fastcgi_module>
  FastCgiConfig -maxClassProcesses 1 -idle-timeout 1500
 
  # Prevent accessing FastCGI alias paths directly
  <LocationMatch "^/fastcgi">
    Order Deny,Allow
    Deny from All
    Allow from env=REDIRECT_STATUS
  </LocationMatch>
 
  FastCgiExternalServer /php-fpm -host 127.0.0.1:9000 -pass-header Authorization -idle-timeout 1500
  ScriptAlias /fastcgiphp /php-fpm
  Action php-fastcgi /fastcgiphp
 
  # Send PHP extensions to PHP-FPM
  AddHandler php-fastcgi .php
 
  # PHP options
  AddType text/html .php
  DirectoryIndex index.php index.html
</IfModule>
 
# Include our VirtualHosts
Include $(dscl . -read /Users/`whoami` NFSHomeDirectory | awk -F"\: " '{print $2}')/Sites/httpd-vhosts.conf
EOF
)
mkdir -pv ~/Sites/{logs,ssl};
touch ~/Sites/httpd-vhosts.conf;
(export USERHOME="/Users/$USER" ; cat > ~/Sites/httpd-vhosts.conf <<EOF
#
# Listening ports.
#
#Listen 8080  # defined in main httpd.conf
Listen 8443
 
#
# Use name-based virtual hosting.
#
NameVirtualHost *:8080
NameVirtualHost *:8443
 
#
# Set up permissions for VirtualHosts in ~/Sites
#
<Directory "$USERHOME/Sites">
    Options Indexes FollowSymLinks MultiViews
    AllowOverride All
    Order allow,deny
    Allow from all
</Directory>
 
# For http://localhost in the users' Sites folder
<VirtualHost _default_:8080>
    ServerName localhost
    DocumentRoot "$USERHOME/Sites"
</VirtualHost>
<VirtualHost _default_:8443>
    ServerName localhost
    Include "$USERHOME/Sites/ssl/ssl-shared-cert.inc"
    DocumentRoot "$USERHOME/Sites"
</VirtualHost>
 
#
# VirtualHosts
#
 
## Manual VirtualHost template for HTTP and HTTPS
#<VirtualHost *:8080>
#  ServerName project.dev
#  CustomLog "$USERHOME/Sites/logs/project.dev-access_log" combined
#  ErrorLog "$USERHOME/Sites/logs/project.dev-error_log"
#  DocumentRoot "$USERHOME/Sites/project.dev"
#</VirtualHost>
#<VirtualHost *:8443>
#  ServerName project.dev
#  Include "$USERHOME/Sites/ssl/ssl-shared-cert.inc"
#  CustomLog "$USERHOME/Sites/logs/project.dev-access_log" combined
#  ErrorLog "$USERHOME/Sites/logs/project.dev-error_log"
#  DocumentRoot "$USERHOME/Sites/project.dev"
#</VirtualHost>
 
#
# Automatic VirtualHosts
#
# A directory at $USERHOME/Sites/webroot can be accessed at http://webroot.dev
# In Drupal, uncomment the line with: RewriteBase /
#
 
# This log format will display the per-virtual-host as the first field followed by a typical log line
LogFormat "%V %h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combinedmassvhost
 
# Auto-VirtualHosts with .dev
<VirtualHost *:8080>
  ServerName dev
  ServerAlias *.dev
 
  CustomLog "$USERHOME/Sites/logs/dev-access_log" combinedmassvhost
  ErrorLog "$USERHOME/Sites/logs/dev-error_log"
 
  VirtualDocumentRoot $USERHOME/Sites/%-2+
</VirtualHost>
<VirtualHost *:8443>
  ServerName dev
  ServerAlias *.dev
  Include "$USERHOME/Sites/ssl/ssl-shared-cert.inc"
 
  CustomLog "$USERHOME/Sites/logs/dev-access_log" combinedmassvhost
  ErrorLog "$USERHOME/Sites/logs/dev-error_log"
 
  VirtualDocumentRoot $USERHOME/Sites/%-2+
</VirtualHost>
EOF
)
(export USERHOME="/Users/$USER" ; cat > ~/Sites/ssl/ssl-shared-cert.inc <<EOF
SSLEngine On
SSLProtocol all -SSLv2 -SSLv3
SSLCipherSuite ALL:!ADH:!EXPORT:!SSLv2:RC4+RSA:+HIGH:+MEDIUM:+LOW
SSLCertificateFile "$USERHOME/Sites/ssl/selfsigned.crt"
SSLCertificateKeyFile "$USERHOME/Sites/ssl/private.key"
EOF
)
openssl req \
  -new \
  -newkey rsa:2048 \
  -days 3650 \
  -nodes \
  -x509 \
  -subj "/C=US/ST=State/L=City/O=Organization/OU=$(whoami)/CN=*.dev" \
  -keyout ~/Sites/ssl/private.key \
  -out ~/Sites/ssl/selfsigned.crt;
# Setup auto start
ln -sfv $(brew --prefix httpd22)/homebrew.mxcl.httpd22.plist ~/Library/LaunchAgents;
launchctl load -Fw ~/Library/LaunchAgents/homebrew.mxcl.httpd22.plist;
# Allow traffic on port 80 (without root, using port forwarding)
sudo bash -c 'export TAB=$'"'"'\t'"'"'
cat > /Library/LaunchDaemons/co.echo.httpdfwd.plist <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
${TAB}<key>Label</key>
${TAB}<string>co.echo.httpdfwd</string>
${TAB}<key>ProgramArguments</key>
${TAB}<array>
${TAB}${TAB}<string>sh</string>
${TAB}${TAB}<string>-c</string>
${TAB}${TAB}<string>echo "rdr pass proto tcp from any to any port {80,8080} -> 127.0.0.1 port 8080" | pfctl -a "com.apple/260.HttpFwdFirewall" -Ef - &amp;&amp; echo "rdr pass proto tcp from any to any port {443,8443} -> 127.0.0.1 port 8443" | pfctl -a "com.apple/261.HttpFwdFirewall" -Ef - &amp;&amp; sysctl -w net.inet.ip.forwarding=1</string>
${TAB}</array>
${TAB}<key>RunAtLoad</key>
${TAB}<true/>
${TAB}<key>UserName</key>
${TAB}<string>root</string>
</dict>
</plist>
EOF'
sudo launchctl load -Fw /Library/LaunchDaemons/co.echo.httpdfwd.plist;
# aliases
echo "# Apache
alias apache.start='brew services start httpd22'
alias apache.stop='brew services stop httpd22'
alias apache.restart='brew services restart httpd22'

# Apache/PHP Logs
alias www.error='tail -250f $(brew --prefix)/var/log/apache2/error_log'
alias www.access='tail -250f $(brew --prefix)/var/log/apache2/access_log'
" >> ~/.profile;
### /Apache ### 
#
### PHP 5.6 ###
# i said "let me introduce myself"
echo -e "$e_info installing 'php56'";
brew install -v homebrew/php/php56 --with-fpm --without-snmp;
(export USERHOME="/Users/$USER" ; sed -i '-default' -e 's|^;\(date\.timezone[[:space:]]*=\).*|\1 \"'$(sudo systemsetup -gettimezone|awk -F"\: " '{print $2}')'\"|; s|^\(memory_limit[[:space:]]*=\).*|\1 512M|; s|^\(post_max_size[[:space:]]*=\).*|\1 200M|; s|^\(upload_max_filesize[[:space:]]*=\).*|\1 100M|; s|^\(default_socket_timeout[[:space:]]*=\).*|\1 600|; s|^\(max_execution_time[[:space:]]*=\).*|\1 300|; s|^\(max_input_time[[:space:]]*=\).*|\1 600|; $a\'$'\n''\'$'\n''; PHP Error log\'$'\n''error_log = '$USERHOME'/Sites/logs/php-error_log'$'\n' $(brew --prefix)/etc/php/5.6/php.ini);
chmod -R ug+w $(brew --prefix php56)/lib/php; #Fix a pear and pecl permissions problem:
pear config-set php_ini $(brew --prefix)/etc/php/5.6/php.ini system
sed -i '' "s|^\(\[opcache\]\)$|\1"\\$'\n'"; Load the opcache extension"\\$'\n'"zend_extension=opcache.so"\\$'\n'"|; s|^;\(opcache\.enable[[:space:]]*=[[:space:]]*\)0|\11|; s|^;\(opcache\.memory_consumption[[:space:]]*=[[:space:]]*\)[0-9]*|\1256|;" $(brew --prefix)/etc/php/5.6/php.ini;
# setup autostart
ln -sfv $(brew --prefix php56)/*.plist ~/Library/LaunchAgents;
launchctl load -Fw ~/Library/LaunchAgents/homebrew.mxcl.php56.plist;
echo "
# PHP-FPM
alias php.start='brew services start php-fpm'
alias php.stop='brew services stop php-fpm'
alias php.restart='brew services restart php-fpm'
" >> ~/.profile;
### /PHP 5.6 ###
#
### DNSMasq ###
# The end result here is that any DNS request ending in .dev reply with the IP address 127.0.0.1:
brew install -v dnsmasq;
echo 'address=/.dev/127.0.0.1' > $(brew --prefix)/etc/dnsmasq.conf;
echo 'listen-address=127.0.0.1' >> $(brew --prefix)/etc/dnsmasq.conf;
echo 'port=35353' >> $(brew --prefix)/etc/dnsmasq.conf;
# Similar to how we run Apache and PHP-FPM, we'll symlink a launchd plist to ~/Library/LaunchAgents and start:
ln -sfv $(brew --prefix dnsmasq)/homebrew.mxcl.dnsmasq.plist ~/Library/LaunchAgents
launchctl load -Fw ~/Library/LaunchAgents/homebrew.mxcl.dnsmasq.plist
# With DNSMasq running, configure OS X to use your local host for DNS queries ending in .dev:
sudo mkdir -v /etc/resolver 
sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/dev'
sudo bash -c 'echo "port 35353" >> /etc/resolver/dev'
echo -e "$e_info You can use this to test routing: 'ping -c 3 fakedomainthatisntreal.dev'";
echo -e "$e_info If it doesn't work right away, try turning WiFi off and on (or unplug/plug your ethernet cable), or reboot your system."; 
echo -e "$e_info For more details, see: $s_ref"; 
echo -e "$e_input Press [enter] to continue"; 
read
### /DNSMasq ###
### cleanup ###  
brew cleanup;
echo
echo -e "$e_info script has completed.";
echo -e "$e_info homebrew has fairly clear error reporting.";
echo -e "$e_info please scroll up to check for errors and test thoroughly.";
### /cleanup ###
