#!/bin/bash

set -e

WP_DIR="/var/www/html"

# Install wordpress
curl -LO https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
chown -R www-data:www-data $WP_DIR/
chmod -R 755 $WP_DIR/
rm latest.tar.gz

# Set up the wp-config.php file for WordPress
cp $WP_DIR/wp-config-sample.php $WP_DIR/wp-config.php
sed -i "s/database_name_here/$WP_DB_NAME/" $WP_DIR/wp-config.php
sed -i "s/username_here/$WP_DB_USER/" $WP_DIR/wp-config.php
sed -i "s/password_here/$WP_DB_PASSWORD/" $WP_DIR/wp-config.php
sed -i "s/define('DB_HOST', '$WP_DB_HOST');/define('DB_HOST', '$WP_DB_HOST:3306');/" $WP_DIR/wp-config.php

# Generate random salts ?