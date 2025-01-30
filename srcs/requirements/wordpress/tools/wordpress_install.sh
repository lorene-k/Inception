#!/bin/bash

set -e

WP_DIR="/var/www/html"

# Install wordpress
curl -LO https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz $WP_DIR/
chown -R www-data:www-data $WP_DIR/
chmod -R 755 $WP_DIR/
rm latest.tar.gz

# Set up the wp-config.php file for WordPress
cp $WP_DIR/wp-config-sample.php $WP_DIR/wp-config.php
sed -i "s/database_name_here/$MYSQL_DATABASE/" $WP_DIR/wp-config.php
sed -i "s/username_here/$MYSQL_USER/" $WP_DIR/wp-config.php
sed -i "s/password_here/$MYSQL_PASSWORD/" $WP_DIR/wp-config.php

SALTS=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)
sed -i "/# Authentication Unique Keys and Salts/ r /dev/stdin" $WP_DIR/wp-config.php <<< "$SALTS"

exec php-fpm7.4 -F