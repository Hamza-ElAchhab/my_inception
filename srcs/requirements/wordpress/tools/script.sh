#!/bin/bash

#add description


sleep 4



if [ ! -f "/wordpress/wp-config.php" ]; then
    php /my_cli config create --allow-root --path="/wordpress" --dbname=${DATABASE_NAME} --dbuser=${DATABASE_USER_NAME}\
        --dbhost="mariadb" --dbpass=${DATABASE_USER_PASSWORD}
fi



if [ ! -f /already_core_installed ];then
    php /my_cli core install --allow-root --path="/wordpress" --url=${DOMAIN_NAME} --title="MY WORDPRESS SITE" \
        --admin_user=${WORDPRESS_ADMIN_NAME} --admin_email=${WORDPRESS_ADMIN_EMAIL} --admin_password=${WORDPRESS_ADMIN_PASSWORD}
    touch /already_core_installed
fi



if [ ! -f /already_second_user ]; then
    php /my_cli user create --allow-root --path="/wordpress"   ${WORDPRESS_USER}\
        hamzaelachhab99@gmail.com --user_pass=${WORDPRESS_USER_PASS} --role=author
    touch /already_second_user
fi



php /my_cli --allow-root --path=/wordpress option update siteurl "https://hel-achh.42.fr"
php /my_cli --allow-root --path=/wordpress option update home "https://hel-achh.42.fr"


# urlsite mandatory for wordpress to know when src
# home : for build redirect
# different between workder and code that will execute
# worker not who build new URL is the wordpress src code

sed -i "s|^listen =.*|listen = 0.0.0.0:9000|" /etc/php/8.2/fpm/pool.d/www.conf


exec php-fpm8.2 --nodaemonize

