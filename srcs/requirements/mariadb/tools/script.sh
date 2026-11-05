#!/bin/bash


# this script is create a database + user with permissions on it then run the base service



if [ ! -f /var/lib/mysql/.initialized ]; then
    mariadbd --user=mysql &
    sleep 5

    mariadb --execute "CREATE DATABASE ${DATABASE_NAME};"
    mariadb --execute "CREATE USER '${DATABASE_USER_NAME}'@'%' IDENTIFIED BY '${DATABASE_USER_PASSWORD}';"
    mariadb --execute "GRANT ALL PRIVILEGES ON my_database.* TO '${DATABASE_USER_NAME}'@'%';"

    mariadb-admin shutdown
    touch /var/lib/mysql/.initialized
fi

# we specify mysql use, cause it by default runs with root
exec mariadbd --user=mysql --bind-address=0.0.0.0



# the base config path
# /etc/mysql/mariadb.cnf
# other configs --> /etc/mysql/mariadb.conf.d/...

# by default it use 127 and 3306
# listening : means the service use a net sock accept TCP CONNECTION only in 3306

# TCP listening socket.
# الـ TCP Listening Socket هي واحد endpoint كينشئها Linux process باش تستقبل
#  TCP connections جاية من processes أخرى، سواء من نفس الجهاز أو من Network.