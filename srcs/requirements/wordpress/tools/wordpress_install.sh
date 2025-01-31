#!/bin/bash

set -e

if [ -f ./wordpress/wp-config.php ]
then
	echo "Wordpress already configured"
else
    # --- Install wordpress ---
    curl -LO https://wordpress.org/latest.tar.gz
    tar -xvzf latest.tar.gz
    chown -R www-data:www-data wordpress/
    chmod -R 755 wordpress/
    rm latest.tar.gz

    # --- Setup wp-config.php ---
    cp wordpress/wp-config-sample.php wordpress/wp-config.php
    sed -i "s/database_name_here/$MYSQL_DATABASE/" wordpress/wp-config.php
    sed -i "s/localhost/$MYSQL_HOSTNAME/g" wordpress/wp-config.php
    sed -i "s/username_here/$MYSQL_USER/" wordpress/wp-config.php
    sed -i "s/password_here/$MYSQL_PASSWORD/" wordpress/wp-config.php
fi

exec php-fpm7.4 -F