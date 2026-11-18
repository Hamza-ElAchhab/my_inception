#!/bin/bash

# check if already init or not, then run the server and create a database and a user and give him perm to database

if [ ! -f /var/lib/mysql/initialized ]; then
    mariadbd --user=mysql &
    sleep 3

    mariadb --execute "CREATE DATABASE ${DATABASE_NAME};"
    mariadb --execute "CREATE USER ${DATABASE_USER_NAME} IDENTIFIED BY '${DATABASE_USER_PASSWORD}';"
    mariadb --execute "GRANT ALL PRIVILEGES ON ${DATABASE_NAME}.* TO ${DATABASE_USER_NAME}@'%';"

    mariadb-admin shutdown
    touch /var/lib/mysql/initialized
fi

exec mariadbd --user=mysql --bind-address=0.0.0.0
