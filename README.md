# mac-php-dev-env

Scripts for taking a mac from fresh Yosemite install to working dev machine. Including recovery using your old user folder, which resore all my app prefs, keychain (as long as username is the same) and stuff like Microsoft Office 365 Licenses.

 * **install.sh** wrapper menu script (*start here*)
 * **import-user-files.sh** instead of apple user import this is selective backup from a /Users/username folder (maybe a drag/drop export from time machine to the desktop like I did)
 * **lamp.sh** a sweet LAMP envornment (with auto vitual hosts) installed with Homebrew (http://brew.sh/) based on this: https://echo.co/blog/os-x-1010-yosemite-local-development-environment-apache-php-and-mysql-homebrew
 * **dev-tools.sh** more tools not included above like: Composer, Node, and some mac sexy Terminal customizations
 * **gui-tools.sh** all the apps you need: browsers, IDEs, Sublime, Office, Dash, Alfred, CodeRunner installed with Homebrew Cask (http://caskroom.io/) 
 
Because we wanna make this as unattened as possible, I've created some files that are similar to "brewfile" and "caskfile" format for you to customize. Fork first then hack away. The result is a repo on your github account that will provision and resrore your mac to harmony with all your custom tweaks.

 * **selected-user-files.sh** select which folders to transfer to from your old user folder
 * **dev-tools.sh** a hybrid file of brew/composer installs and .profile modifactions.
 * **selected-gui-tools.sh** select your GUI tools here. to see what's availalbe check here: http://caskroom.io/search or simply use ``` 'brew cask search <query>' ``` in your terminal
 
If anyone wants to fork and make a Mavericks branch (or any other relevant branches), just let me know. I may make a Maavericks branch soon anyway so anybody can Pull Request directly to it.