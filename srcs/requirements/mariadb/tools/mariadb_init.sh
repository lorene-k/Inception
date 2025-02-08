#!/bin/sh

chown -R mysql:mysql /var/lib/mysql
chmod -R 755 /var/lib/mysql

chown -R mysql:mysql /run/mysqld
chmod -R 755 /run/mysqld

mysql_install_db > /dev/null

	tfile=`mktemp`
	if [ ! -f "$tfile" ]; then
		return 1
	fi
	cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;

ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';

CREATE DATABASE $MYSQL_DATABASE CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED by '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';

FLUSH PRIVILEGES;
EOF
	mysqld --user=mysql --bootstrap < $tfile

exec mysqld --console



# set -e

# mysqld_safe --skip-networking --socket=/run/mysqld/mysqld.sock &
# sleep 5

# mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
# mysql -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
# mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
# mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
# mysql -e "FLUSH PRIVILEGES;"

# mysqladmin -u root -p "${MYSQL_ROOT_PASSWORD}" shutdown

# exec mysqld --user=mysql --port=3306 --bind-address=0.0.0.0 --socket=/run/mysqld/mysqld.sock



# chown -R mysql:mysql /var/lib/mysql
# chmod -R 755 /var/lib/mysql

# chown -R mysql:mysql /run/mysqld
# chmod -R 755 /run/mysqld

# # if mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "USE ${MYSQL_DATABASE};" 2>/dev/null
# # then
# # 	echo "Mariadb already configured"
# # else
#     # --- Create database and user ---
#     mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
#     mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
#     mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
#     mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
#     mysql -e "FLUSH PRIVILEGES;"
    
#     # --- Initialize WordPress SQL setup ---
#     # mysql -u root -p ${MYSQL_ROOT_PASSWORD} ${MYSQL_DATABASE} < ../../docker-entrypoint-initdb.d/setup.sql
    
# # fi

# # mysql -u root -p "${MYSQL_ROOT_PASSWORD}" -e "SHOW DATABASES;" # TEST

# # exec su mysql -c "mysqld"

# mysql -u root -p${MYSQL_ROOT_PASSWORD} --host=mariadb --port=3306