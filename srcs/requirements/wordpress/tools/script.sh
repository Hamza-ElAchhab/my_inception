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



wp() {
        php -d memory_limit=512M /wp.phar --allow-root --path="$WP_PATH" "$@"
}

# Subject rule: the administrator's name must not contain "admin"
if echo "$WP_ADMIN_USER" | grep -qi "admin"; then
        echo "ERROR: WP_ADMIN_USER must not contain 'admin' or 'administrator'" >&2
        exit 1
fi


tries=0
until mariadb-admin ping --skip-ssl -h database_cntr -u"$MYSQL_USER" -p"$DB_PASS" --silent >/dev/null 2>&1; do
        tries=$((tries + 1))
        if [ "$tries" -ge 60 ]; then
                echo "ERROR: MariaDB not reachable" >&2
                exit 1
        fi
        sleep 2
done

# 1) Files + wp-config.php (first start only; volume persists afterwards)
if [ ! -f "$WP_PATH/wp-config.php" ]; then
        wp config create \
                --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" \
                --dbpass="$DB_PASS" --dbhost=database_cntr --dbcharset=utf8mb4
fi

# 2) Database content: site + two users (administrator + author)
if ! wp core is-installed >/dev/null 2>&1; then
        wp core install \
                --url="https://$DOMAIN_NAME" --title="$WP_TITLE" \
                --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASS" \
                --admin_email="$WP_ADMIN_EMAIL" --skip-email
fi
if ! wp user get "$WP_USER" >/dev/null 2>&1; then
        wp user create "$WP_USER" "$WP_USER_EMAIL" \
                --role=author --user_pass="$WP_USER_PASS"
fi

exec php-fpm8.2 -F

