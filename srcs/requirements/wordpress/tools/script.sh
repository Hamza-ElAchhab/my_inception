#!/bin/sh
set -e

WP_PATH=/wordpress
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


# # client
# while ! mariadb-admin ping --host database_cntr -u"$MYSQL_USER" -p"$DB_PASS"; do
#     sleep 1
# done


# هاد الأمر كينشئ wp-config.php باش WordPress يعرف كيفاش يتصل بـ MariaDB.
if [ ! -f "$WP_PATH/wp-config.php" ]; then

        php /my_cli --allow-root --path="$WP_PATH" config create \
        --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" \
        --dbpass="$DB_PASS" --dbhost=database_cntr
fi



#كنشغّلو wp core install، اللي كيتصل بقاعدة البيانات وكيُنشئ جداول WordPress.
if ! php /my_cli --allow-root --path="$WP_PATH" core is-installed; then

        php /my_cli --allow-root --path="$WP_PATH" core install --url="https://$DOMAIN_NAME" --title="$WP_TITLE" \
                --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASS" \
                --admin_email="$WP_ADMIN_EMAIL"
fi



# create second user behaid the admin
if ! php /my_cli --allow-root --path="$WP_PATH" user get "$WP_USER"; then

        php /my_cli --allow-root --path="$WP_PATH" user create "$WP_USER" "$WP_USER_EMAIL" \
                --role=author --user_pass="$WP_USER_PASS"
fi




exec php-fpm8.2 -F


