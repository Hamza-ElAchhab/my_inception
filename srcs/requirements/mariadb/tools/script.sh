#!/bin/bash

# add description



# بعض الـ Shells تقوم بتحسين (optimization)
# we run with exec form for dont depand on the optimise of shell
# cause it can fork() and dont replace shell with shell even it is one proccess, no need fork()


if [ ! -f /var/lib/mysql/.initialized ]; then
    mariadbd --user=mysql &
    sleep 3

    mariadb --execute "CREATE DATABASE ${DATABASE_NAME};"
    mariadb --execute "CREATE USER ${DATABASE_USER_NAME}@'%' IDENTIFIED BY '${DATABASE_USER_PASSWORD}';"
    mariadb --execute "GRANT ALL PRIVILEGES ON ${DATABASE_NAME}.* TO ${DATABASE_USER_NAME}@'%';"

    mariadb-admin shutdown
    touch /var/lib/mysql/.initialized
fi

# we specify mysql use, cause it by default runs with root
exec mariadbd --user=mysql --bind-address=0.0.0.0





# the base config path
# /etc/mysql/mariadb.cnf
# other configs --> /etc/mysql/mariadb.conf.d/...

