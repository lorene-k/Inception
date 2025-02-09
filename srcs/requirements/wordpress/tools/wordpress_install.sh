#!/bin/bash

set -e

if [ -f wp-config.php ]
then
	echo "Wordpress already configured"
else
    sleep 2
    # --- Install wordpress ---
    curl -LO https://wordpress.org/latest.tar.gz
    tar -xvzf latest.tar.gz
    chown -R www-data:www-data ./
    chmod -R 755 ./
    mv wordpress/* ./
    rm latest.tar.gz

    # --- Setup wp-config.php ---
    cp wp-config-sample.php wp-config.php
    sed -i "s/database_name_here/${MYSQL_DATABASE}/" wp-config.php
    sed -i "s/localhost/${MYSQL_HOSTNAME}/" wp-config.php
    sed -i "s/username_here/${MYSQL_USER}/" wp-config.php
    sed -i "s/password_here/${MYSQL_PASSWORD}/" wp-config.php
fi

exec php-fpm7.4 -F
