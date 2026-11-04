#!/bin/bash


sleep 10


if [ ! -f "/wordpress/wp-config.php" ]; then
    php /my_cli config create --allow-root --path="/wordpress/" --dbname="my_database" \
    --dbuser="my_user" --dbhost=database --dbpass="koko.kaka.1234"
fi



if [ ! -f /already_core_installed ];then
    php /my_cli core install --allow-root --path="/wordpress/" --url="https://127.0.0.1/" \
    --title="my_site" --admin_user="hel-achh" --admin_email="hel-achh@gmail.com"
    touch /already_core_installed
fi
#nano /etc/hosts --> 127.0.0.1  hamza.42.fr.



if [ ! -f /already_second_user ]; then
    php /my_cli user create --allow-root --path="/wordpress/" hamza_achhab hamzaelachhab@gmail.com
    touch /already_second_user
fi



sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php/8.2/fpm/pool.d/www.conf
# listen = /run/php/php8.2-fpm.sock / default. with no port.




exec php-fpm8.2 --nodaemonize

