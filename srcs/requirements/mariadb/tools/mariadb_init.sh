#!/bin/bash

set -e

chown -R mysql:mysql /var/lib/mysql
chmod -R 755 /var/lib/mysql

chown -R mysql:mysql /run/mysqld
chmod -R 755 /run/mysqld

if mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "USE ${MYSQL_DATABASE};" 2>/dev/null
then
	echo "Mariadb already configured"
else
    # --- Start MariaDB temporarily ---
    mysqld_safe --skip-networking --socket=/run/mysqld/mysqld.sock &
    sleep 5

    # --- Create database and user ---
    # mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
    # mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    # mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
    # mysql -e "FLUSH PRIVILEGES;"
    
    # --- Initialize WordPress SQL setup ---
    mysql -u root -p ${MYSQL_ROOT_PASSWORD} ${MYSQL_DATABASE} < /docker-entrypoint-initdb.d/setup.sql
    
    #--- Stop temporary MariaDB ---
    mysqladmin -u root -p "${MYSQL_ROOT_PASSWORD}" shutdown
fi

exec su -s /bin/bash mysql -c "mysqld"