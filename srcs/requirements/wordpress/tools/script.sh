#!/bin/sh
set -e

WP_PATH=/src_wordpress
DB_PASS=1234
WP_ADMIN_PASS=1234
WP_USER_PASS=1234

# temp
MYSQL_USER=my_user
MYSQL_DATABASE=my_database
WP_ADMIN_USER=hamza_manager
WP_ADMIN_EMAIL=hamza_manager@example.com
WP_USER=wp_author
WP_USER_EMAIL=wp_author@example.com
WP_TITLE="My WordPress Site"
DOMAIN_NAME=hamza.42.fr



until mariadb-admin ping --host database_cntr -u"$MYSQL_USER" -p"$DB_PASS"; do
    sleep 1
done



if [ ! -f "$WP_PATH/wp-config.php" ]; then

        php /wp.phar --allow-root --path="$WP_PATH" config create \
        --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" \
        --dbpass="$DB_PASS" --dbhost=database_cntr
fi



if [ ! php /wp.phar --allow-root --path="$WP_PATH" core is-installed ]; then

        php /wp.phar --allow-root --path="$WP_PATH" core install --url="https://$DOMAIN_NAME" --title="$WP_TITLE" \
                --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASS" \
                --admin_email="$WP_ADMIN_EMAIL" --skip-email
fi



if ! php /wp.phar --allow-root --path="$WP_PATH" user get "$WP_USER"; then

        php /wp.phar --allow-root --path="$WP_PATH" user create "$WP_USER" "$WP_USER_EMAIL" \
                --role=author --user_pass="$WP_USER_PASS"
fi



# php-fpm8.2 this no need php interpreter he already has executable ready
# thsi php-fpm8.2 runs php code وكيستقبل طلبات تنفيذ هاد الكود من
# and he always return HTML or json to browser
exec php-fpm8.2 -F

