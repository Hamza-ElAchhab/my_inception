# this script is create a database + user with permissions on it then run the base service

#!/bin/bash

DB_PASS=1234
DB_ROOT_PASS=1234
MYSQL_DATABASE="my_database"
MYSQL_USER="my_user"



# [] this is a test cmd it is check the result and give only exit 0 or exit 1
# 0 means true
# 1 means false
# [] are not a part of shell syntax are cmds and arguments
# so [ is cmd test and -f for check a regeral file and ] end of arguments


if [ ! -f /var/lib/mysql/.initialized ]; then
    mariadbd --user=mysql &


    sleep 10
    # while ! mariadb-admin ping; do
    #     sleep 1
    # done


    mariadb --execute "CREATE DATABASE my_database;"
    mariadb --execute "CREATE USER 'my_user'@'%' IDENTIFIED BY 'koko.kaka.1234';"
    mariadb --execute "GRANT ALL PRIVILEGES ON my_database.* TO my_user@'%';"



    mariadb-admin shutdown
    touch /var/lib/mysql/.initialized
fi

exec mariadbd --user=root --bind-address=0.0.0.0

