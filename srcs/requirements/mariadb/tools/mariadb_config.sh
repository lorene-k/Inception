#!/bin/bash

set -e

chown -R mysql:mysql /var/lib/mysql
chmod -R 755 /var/lib/mysql

if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]
then
	echo "Mariadb already configured"
else
    # --- Create database and user ---
    mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
    mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
    mysql -e "FLUSH PRIVILEGES;"
    
    # service mysql stop # unnecessary if service not started
fi

exec su -s /bin/bash mysql -c "mysqld"