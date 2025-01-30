#!/bin/bash

set -e

# Install wordpress
curl -LO https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
chown -R www-data:www-data wordpress/
chmod -R 755 wordpress/
rm latest.tar.gz

# Set up the wp-config.php file for WordPress
cp wordpress/wp-config-sample.php wordpress/wp-config.php
sed -i "s/database_name_here/$MYSQL_DATABASE/" wordpress/wp-config.php
sed -i "s/username_here/$MYSQL_USER/" wordpress/wp-config.php
sed -i "s/password_here/$MYSQL_PASSWORD/" wordpress/wp-config.php

# SALTS=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)
# sed -i "/# Authentication Unique Keys and Salts/ r /dev/stdin" ./wp-config.php <<< "$SALTS"

exec php-fpm7.4 -F