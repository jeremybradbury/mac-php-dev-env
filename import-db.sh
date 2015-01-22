#!/bin/sh
source colors.sh;
## selector-db.sh ## Select the db import files
##
echo -e "e_input where is your backup file?";
read ": " sql_import # the selected import
# sql_import="~/Desktop/jeremy/Documents/backup.sql"; # manual override
my_db_backup="import.sh-$(date | sed -e 's/ /_/g').sql"; # just in case =]
echo "$e_info backing up existing db to: $CWD/$my_db_backup";
read; # can always cmd-c out now
mysqldump -u root -p --all-databases > $my_db_backup;
echo "$e_info importing from $sql_import";
read; # can always cmd-c out now
mysql -u root -p -h < $sql_import;