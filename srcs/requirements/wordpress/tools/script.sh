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
        hamzaelachhab99@gmail.com --user_pass=${WORDPRESS_USER_PASS}
    touch /already_second_user
fi


# 443 will added manual
php /my_cli option update siteurl "https://hel-achh.42.fr" --path=/wordpress --allow-root
php /my_cli option update home "https://hel-achh.42.fr" --path=/wordpress --allow-root





sed -i "s|^listen = .*|listen = 0.0.0.0:9000|" /etc/php/8.2/fpm/pool.d/www.conf
# listen = /run/php/php8.2-fpm.sock / default. with no port.


exec php-fpm8.2 --nodaemonize




# siteurl and home they storage in database when we do coreinstall,


# Filesystem:
#     /wordpress/

# Database (wp_options):
#     siteurl = https://hel-achh.42.fr:1234 -> mandatory for can wordpress (fpm workers) build the next URL for browser
#     home    = https://hel-achh.42.fr:1234

# siteurl
# WordPress installation
# example.com/wordpress
# فين كاين WordPress نفسه؟

# home
# Website visitors
# example.com
# شنو هو العنوان اللي كيدخل ليه الزائر؟

# so siteurl for find where is the src code in filesys
# and home for build the request

