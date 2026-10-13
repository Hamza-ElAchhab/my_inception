#!/bin/bash


DB_PASS=1234
DB_ROOT_PASS=1234
MYSQL_DATABASE="my_database"
MYSQL_USER="my_user"

set -e


if [ ! -f /var/lib/mysql/.initialized ]; then
    mariadbd --user=mysql --console &
    pid=$!


    while ! mariadb-admin ping; do
        sleep 1
    done

    mariadb --user root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';"
    mariadb --user root -p"${DB_ROOT_PASS}" -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
    mariadb --user root -p"${DB_ROOT_PASS}" -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PASS}';"
    mariadb --user root -p"${DB_ROOT_PASS}" -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"

#مصدر الاتصال (Host).
#give permission to the use on all tables in this database only.

#     mariadb --user root << EOF
#     ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';
#     CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
#     CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
#     GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
# EOF

    mariadb-admin -u root -p"${DB_ROOT_PASS}" shutdown
    wait "$pid" || true
    touch /var/lib/mysql/.initialized
fi


exec mariadbd --user=mysql

