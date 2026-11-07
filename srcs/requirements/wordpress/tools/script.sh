#!/bin/bash

#add description



# can word press works without coreinstall : no should do it manual.
# إذا حاولت فتح الموقع، سيطلب منك WordPress إكمال التثبيت.
sleep 4



# # mysqli_init(): this part needs mysqli extention from PHP Extension
# mysqli هي PHP Extension كتسمح لبرامج PHP يتواصلو مع MySQL وMariaDB باستعمال بروتوكول MySQL.
if [ ! -f "/wordpress/wp-config.php" ]; then
    php /my_cli config create --allow-root --path="/wordpress" --dbname=${DATABASE_NAME} --dbuser=${DATABASE_USER_NAME}\
        --dbhost="mariadb" --dbpass=${DATABASE_USER_PASSWORD}
fi


# this part too need the exetention for start creation of tables.
# url : mandatory for can wordpress knows the base URL not just nginx, it is mandatory for the redirection
# if user will change the current page with other should build the URL again and append the URL
# for send it as response
# لكي يستطيع إنشاء الروابط الصحيحة داخل الصفحات التي يرسلها للمتصفح
# --title="MY WORDPRESS SITE  just for dispaly

if [ ! -f /already_core_installed ];then
    php /my_cli core install --allow-root --path="/wordpress" --url=${WORDPRESS_URL} --title="MY WORDPRESS SITE" \
        --admin_user=${WORDPRESS_ADMIN_NAME} --admin_email=${WORDPRESS_ADMIN_EMAIL} --admin_password=${WORDPRESS_ADMIN_PASSWORD}
    touch /already_core_installed
fi



if [ ! -f /already_second_user ]; then
    php /my_cli user create --allow-root --path="/wordpress" ${WORDPRESS_USER}\
        hamzaelachhab99@gmail.com --user_pass=${WORDPRESS_USER_PASS}
    touch /already_second_user
fi


# regular exp
# sed is a text editor -i for edit in-place , by default edit only in terminal
# s: for the type proccess (substute)
# |: seperator
# ^listen : any line start with
sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php/8.2/fpm/pool.d/www.conf
# listen = /run/php/php8.2-fpm.sock / default. with no port.



# you realy up him to pid1 should stay in it, dont make him split him self.
exec php-fpm8.2 --nodaemonize



# #nano /etc/hosts --> 127.0.0.1  hamza.42.fr.

