#!/bin/bash

DB_PASS=1234
DB_ROOT_PASS=1234
MYSQL_DATABASE="my_database"
MYSQL_USER="my_user"


if [ ! -f /var/lib/mysql/.initialized ]; then
    mariadbd --user=mysql &


    while ! mariadb-admin ping; do
        sleep 1
    done


    mariadb --execute "CREATE DATABASE IF NOT EXISTS my_database;"


    mariadb-admin shutdown
    touch /var/lib/mysql/.initialized
fi


exec mariadbd --user=mysql --bind-address=0.0.0.0


# fishcorr



# database by default with no password, but after this :
# mariadb --user root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';" will be with a password
# ALTER USER: modified on an acount in database server
# root : the name of acount
# localhost : only from local
# IDENTIFIED BY '1234' add mode pass

# not important
#     mariadb --execute "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';"
    # mariadb --execute "CREATE USER IF NOT EXISTS my_user IDENTIFIED BY 'koko.kaka.1234';"
    # mariadb --execute "GRANT ALL PRIVILEGES ON my_database TO my_user;"
