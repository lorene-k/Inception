#!/bin/bash

set -e

if [ -f wp-config.php ]
then
	echo "Wordpress already configured"
else
    sleep 2

    # --- Set permissions ---
    chown -R www-data:www-data ./
    chmod -R 755 ./

    # --- Download and extract WordPress ---
    curl -LO https://wordpress.org/latest.tar.gz
    tar -xvzf latest.tar.gz
    mv wordpress/* ./
    rm -rf wordpress latest.tar.gz

    # --- Setup wp-config.php ---
    wp config create \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --dbhost="$MYSQL_HOSTNAME" \
        --allow-root

    # --- Install WordPress ---
    wp core install \
        --url="$DOMAIN_NAME" \
        --title="42_Inception Wordpress" \
        --admin_user="$WP_ADM_USER" \
        --admin_password="$WP_ADM_PW" \
        --admin_email="wpboss@test.com" \
        --allow-root

    # --- Create Editor User ---
    wp user create "$WP_USER" "randomuser@test.com" \
        --role=editor \
        --user_pass="$WP_PW" \
        --allow-root
fi

exec php-fpm7.4 -F