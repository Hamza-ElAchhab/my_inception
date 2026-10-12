#!/bin/bash


set -e




mariadbd --user=mysql --console &
# service mariadb start

# pid=$!


until mariadb-admin ping --silent; do
    sleep 1
done


mariadb -u root -p"${DB_ROOT_PASS}" <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
SHUTDOWN;
EOF


wait


exec mariadbd --user=mysql --console
